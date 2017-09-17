require 'rails_helper'

feature "Manage songs", js:true do
  let(:artist) { create :artist, name: "Clannad" }

  scenario "add a new song" do

    visit artist_path(artist)

    fill_in "song_name", with: "Court To Love"

    page.execute_script("$('#new_song').submit()")

    expect(page).to have_content("Court To Love")
  end
end
