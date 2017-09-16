class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    if params[:order] == "name"
      @artists.merge!(Artist.order("name ASC"))
    elsif params[:order] == "creation"
      @artists.merge!(Artist.order("created_at DESC"))
    end
  end

  def show
    @artist = Artist.find(params[:id])
    @songs = @artist.songs
    @song = @artist.songs.new
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to artist_path(@artist), notice: "Artist created!"
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      redirect_to @artist, notice: "Artist updated!"
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])

    @artist.destroy

    redirect_to artists_path
  end

private

  def artist_params
  params
    .require(:artist)
    .permit(:name, :image_url, song_ids: [])
  end

end
