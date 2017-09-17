class Api::SongsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :find_artist

  def index
    render status: 200, json: {
      songs: @artist.songs.all
    }.to_json
  end

  def create
    song = @artist.songs.new(song_params)

    if song.save
      render status: 201, json: {
        message: "Song created",
        song: song
      }.to_json
    else
      render status: 422, json: {
        errors: song.errors
      }.to_json
    end
  end

  def destroy
    song = @artist.songs.find(params[:id])
    song.destroy

    render status: 200, json: {
      message: "Song deleted"
    }.to_json
  end

  def find_artist
    @artist = Artist.find(params[:artist_id])
  end

  private

  def song_params
    params
      .require(:song)
      .permit(:name)
  end

end
