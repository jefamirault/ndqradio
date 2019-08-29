require 'shout'
require 'open-uri'

class RadioWorker
  include Sidekiq::Worker

  def perform(*_args)
    s = Shout.new
    s.mount = '/stream'
    s.charset = 'UTF-8'
    s.port = 8000
    s.host = 'localhost'
    s.user = ENV['ICECAST_USER']
    s.pass = ENV['ICECAST_PASSWORD']
    s.format = Shout::MP3
    s.description = 'NDQ Radio'
    s.connect

    prev_ep = nil

    
    loop do # endless streaming
      Episode.where(current: true).each do |ep|
        ep.toggle! :current
      end
      Episode.order('created_at DESC').each do |ep|
        prev_ep.toggle!(:current) if prev_ep
        ep.toggle! :current

        open(ep.track.url(public: true)) do |file|
          m = ShoutMetadata.new
          m.add 'filename', ep.track.original_filename
          m.add 'title', ep.title
          m.add 'date', ep.date.to_s
          s.metadata = m

          while data = file.read(16384) # block size
            s.send data
            s.sync
          end
        end
        prev_ep = ep
      end
    end  
    
    s.disconnect
  end
end
