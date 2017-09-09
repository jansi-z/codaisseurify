require 'rails_helper'

RSpec.describe Artist, type: :model do

  describe "validations" do
    it "is invalid without a name" do
      artist = Artist.new(name: "")
      artist.valid?
      expect(artist.errors).to have_key(:name)
    end

    it "is invalid with a name exceeding 50 characters" do
      artist = Artist.new(name: "L" * 51)
      artist.valid?
      expect(artist.errors).to have_key(:name)
    end

    it "is invalid without an image url" do
      artist = Artist.new(image_url: "")
      artist.valid?
      expect(artist.errors).to have_key(:image_url)
    end
  end

  describe "association with songs" do
    let(:artist)  { create :artist }

    it "can have many songs" do
      song1 = Song.new(artist: artist)
      song2 = Song.new(artist: artist)

      expect(artist.songs).to include(song1)
      expect(artist.songs).to include(song2)
    end
  end
end
