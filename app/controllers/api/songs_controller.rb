class Api::SongsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render status: 200, json: {
      songs: Artist.find(params[:artist_id]).songs.all
    }.to_json
  end

  def create
    song = Artist.find(params[:artist_id]).songs.new(song_params)

    if song.save
      render status: 201, json: {
        message: "Song successfully created",
        song: song
      }.to_json
    else
      render status: 422, json: {
        errors: song.errors
      }.to_json
    end
  end

  private

  def song_params
    params
      .require(:song)
      .permit(:name)
  end

end
