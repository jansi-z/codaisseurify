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

  def show
    @song = Song.find(params[:id])
    @artist = @song.artist
  end

  def destroy
    @song = Song.find(params[:id])
    @artist = @song.artist
    @song.destroy
    redirect_to artist_path(@artist)
  end

  private

  def song_params
    params
      .require(:song)
      .permit(:name, :artist_id)
    end

end
