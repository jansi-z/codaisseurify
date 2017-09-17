require 'rails_helper'

feature "Manage songs", js:true do
  let(:artist) { create :artist, name: "Clannad" }

  scenario "add a new song" do

    visit artist_path(artist)

    fill_in "song_name", with: "Court To Love"

    page.execute_script("$('#new_song').submit()")

    expect(page).to have_content("Court To Love")
  end

  scenario "add a song without a title" do

    visit artist_path(artist)

    fill_in "song_name", with: ""

    page.execute_script("$('#new_song').submit()")
    sleep(1)
    expect(page.find(:css, 'span#error_message').text).to eq("Not a valid song name")
  end
end
