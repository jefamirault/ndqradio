class Episode < ApplicationRecord
  include EpisodeUploader[:track]

  validates :title, presence: true
  validates :date,  presence: true
  validates :track, presence: true
end
