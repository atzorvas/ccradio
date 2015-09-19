//  This is a manifest file that'll be compiled into application.js, which will include all the files
//  listed below.
//
//  Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
//  or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
//  It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
//  compiled file.
//
//  Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
//  about supported directives.
//
//= require jquery
//= require jplayer/jquery.jplayer.js
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbograft
//= require_tree .

function playerDef(title, link) {
  var stream = {
    title: title, //"Everything",
    mp3: link //"http://stream.creativecommons.gr:8000/live0",
  },
  ready = false;

  $("#jquery_jplayer_1").jPlayer({
    ready: function (event) {
      ready = true;
      $(this).jPlayer("setMedia", stream).jPlayer("play");
    },
    pause: function() {
      $(this).jPlayer("clearMedia");
    },
    error: function(event) {
      if(ready && event.jPlayer.error.type === $.jPlayer.error.URL_NOT_SET) {
        // Setup the media stream again and play it.
        $(this).jPlayer("setMedia", stream).jPlayer("play");
      }
    },
    supplied: "mp3",
    preload: "none",
    wmode: "window",
    useStateClassSkin: true,
    autoBlur: false,
    keyEnabled: true
  });
}

$(document).on("page:load page:update", function(){
  // Change Station
  $('.player-link').on('click', function(evt) {
    evt.preventDefault();
    $("#jquery_jplayer_1").jPlayer( "destroy" );

    var link = evt.target.getAttribute('data-url');
    var title = evt.target.getAttribute('data-title');
    playerDef(title, link);
  });
});
