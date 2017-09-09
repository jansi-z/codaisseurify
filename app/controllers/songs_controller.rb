class SongsController < ApplicationController

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params.merge(artist_id: params[:artist_id]))
    @song.save 
    if @song.save
      redirect_to artist_path(@song.artist), notice: "Song added!"
    else
      render :new
    end
  end

  private

  def song_params
    params
      .require(:song)
      .permit(:name, :artist_id)
    end

end
