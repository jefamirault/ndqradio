class EpisodesController < ApplicationController
  layout 'admin'

  def index
    @episodes = Episode.all
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new episode_params
    if @episode.save
      redirect_to episodes_path
    else
      render :new
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :date, :track)
  end
  
end