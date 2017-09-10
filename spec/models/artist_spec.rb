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

    it "is invalid with a name that already exists" do
      Artist.create!(name: "Jorge Ben Hor")
      artist2 = Artist.new(name: "Jorge Ben Hor")
      artist2.valid?
      expect(artist2.errors).to have_key(:name)
    end
  end

  describe "association with songs" do
    let(:artist)  { create :artist }
    let!(:song)   { create :song, artist: artist }

    it "can have many songs" do
      song1 = artist.songs.build
      song2 = artist.songs.build

      expect(artist.songs).to include(song1)
      expect(artist.songs).to include(song2)
    end

    it "deletes associated songs" do
      expect { artist.destroy }.to change(Artist, :count).by(-1)
    end
  end
end
