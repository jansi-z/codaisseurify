function nextSongId() {
  return $(".song").size() + 1;
}

function createSong(name) {
  var songId = "song-" + nextSongId();

  var listItem = $('<li class="song"></li>')
    .attr('for', songId)
    .html(name);

  $("#songList").append( listItem );
}

function submitSong(event) {
  event.preventDefault();
  createSong($("#song_name").val());
  $("#song_name").val(null);
}

function deleteAllSongs(event) {
  event.preventDefault();
  $.when($(".song").remove())
}

$(document).ready(function() {
  $("form").bind('submit', submitSong);
  $("#clean-up").bind('click', deleteAllSongs);
});
