function nextSongId() {
  return $(".song").size() + 1;
}

function createSong(name) {
  var songId = "song-" + nextSongId();

  var listItem = $('<li class="song"></li>')
    .attr('for', songId)
    .html(name + '<a href="#" class="delete-song">Delete</a>');

  $("#songList").append( listItem );

  var newSong = { name: name };
  var artistId = $('.header').attr('id');

  $.ajax({
    type: "POST",
    url: "/api/artists/"+artistId+"/songs.json",
    data: JSON.stringify({
        song: newSong
    }),
    contentType: "application/json",
    dataType: "json"
  });
  $(".delete-song").bind('click', deleteSingleSong);
}

function submitSong(event) {
  event.preventDefault();
  createSong($("#song_name").val());
  $("#song_name").val(null);
}

function deleteAllSongs(event) {
  event.preventDefault();

  $.each($(".song"), function(index, listItem) {
    songId = $(listItem).data('id');
    deleteSong(songId);
  });
}

function deleteSingleSong(event) {
  var deleteButton = this;
  var songItem = $(this).parent();
  var songId = $(songItem).data('id');

  deleteSong(songId);

}

function deleteSong(songId) {
  var artistId = $('.header').attr('id');

  $.ajax({
    type: "DELETE",
    url: "/api/artists/"+artistId+"/songs/"+songId+".json",
    contentType: "application/json",
    dataType: "json"
  })
  .done(function(data) {
    $('li[data-id="'+songId+'"]').remove();
  });
}

$(document).ready(function() {
  $("#new_song").bind('submit', submitSong);
  $("#clean-up").bind('click', deleteAllSongs);
  $(".delete-song").bind('click', deleteSingleSong);
});
