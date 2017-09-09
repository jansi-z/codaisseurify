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
end
