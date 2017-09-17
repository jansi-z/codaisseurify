function createSong(name) {

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
  })

  .done(function(data){
    console.log(data);

    var songId = data.song.id;

    var listItem = $('<li class="song"></li>')
      .attr('data-id', songId)
      .html(name + '<a href="#" class="delete-song">  Delete</a>');

    $("#songList").append(listItem);

    $(".delete-song").bind('click', deleteSingleSong);
  })

  .fail(function(error) {
    console.log(error);
    error_message = error.responseJSON.errors.name;
    showError(error_message);
  });
}

function showError(message) {
  var errorHelpBlock = $('<span class="help-block"></span>')
    .attr('id', 'error_message')
    .text(message);
  $("#formgroup-title")
    .addClass("has-error")
    .append(errorHelpBlock);
}

function resetErrors() {
  $("#error_message").remove();
  $("#formgroup-title").removeClass("has-error");
}

function submitSong(event) {
  event.preventDefault();
  resetErrors();
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
