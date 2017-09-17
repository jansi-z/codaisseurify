require 'rails_helper'

feature "Manage songs", js:true do
  let!(:artist)    { create :artist, name: "Clannad" }
  let!(:song)      { create :song, name: "Let Me See", artist: artist }

  scenario "add a new song" do

    visit artist_path(artist)

    fill_in "song_name", with: "Court To Love"

    page.execute_script("$('#new_song').submit()")

    expect(page).to have_content("Court To Love")
  end

  scenario "can't add a song without a name" do

    visit artist_path(artist)

    fill_in "song_name", with: ""

    page.execute_script("$('#new_song').submit()")
    sleep(1)
    expect(page.find(:css, 'span#error_message').text).to eq("can't be blank")
  end

  scenario "remove a song" do

    visit artist_path(artist)

    click_on("Delete")
    sleep(1)
    list = find('#songList').all('li')

    expect(list.size).to eq(0)
  end

  scenario "remove all songs" do

    visit artist_path(artist)

    fill_in "song_name", with: "Fado"

    page.execute_script("$('#new_song').submit()")
    sleep(1)
    click_on("Delete all songs")
    sleep(1)
    list = find('#songList').all('li')
    expect(list.size).to eq(0)
  end

end
