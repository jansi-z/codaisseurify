class SongsController < ApplicationController

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params.merge(artist_id: params[:artist_id]))

    respond_to do |format|
      if @song.save
        format.html { redirect_to artist_path(@song.artist), notice: "Song added!" }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { redirect_to artist_path(@song.artist), notice: "Unable to add song." }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
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
