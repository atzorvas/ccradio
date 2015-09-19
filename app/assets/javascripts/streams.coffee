# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  socket = new WebSocket "ws://#{window.location.host}/stream_subscription"

  action = $("body").attr 'data-action'

  if action == 'index'
    socket.onmessage = (event) ->
      if event.data.length
        song = JSON.parse(event.data).song
        $("[stream-id=#{song.stream_id}] td.song").fadeOut 500, ->
          $(this).text(song.song).fadeIn 500
          return

$ ->
  stream =
    title: "Everything"
    mp3: "http://stream.creativecommons.gr:8000/live0"
    song: "Test Song"

  ready = false
  $("#jquery_jplayer_1").jPlayer
    ready: (event) ->
      ready = true
      $(this).jPlayer("setMedia", stream).jPlayer "play"

    pause: ->
      $(this).jPlayer "clearMedia"

    error: (event) ->

      # Setup the media stream again and play it.
      $(this).jPlayer("setMedia", stream).jPlayer "play"  if ready and event.jPlayer.error.type is $.jPlayer.error.URL_NOT_SET

    supplied: "mp3"
    preload: "none"
    wmode: "window"
    useStateClassSkin: true
    autoBlur: false
    keyEnabled: true


  # Change Station
  $(".player-link").on "click", (evt) ->
    evt.preventDefault()
    $("#jquery_jplayer_1").jPlayer "destroy"
    ready = false
    link = evt.target.getAttribute("data-url")
    title = evt.target.getAttribute("data-title")
    stream =
      title: title
      mp3: link

    $("#jquery_jplayer_1").jPlayer
      ready: (event) ->
        ready = true
        $(this).jPlayer("setMedia", stream).jPlayer "play"

      pause: ->
        $(this).jPlayer "clearMedia"

      error: (event) ->

        # Setup the media stream again and play it.
        $(this).jPlayer("setMedia", stream).jPlayer "play"  if ready and event.jPlayer.error.type is $.jPlayer.error.URL_NOT_SET

      supplied: "mp3"
      preload: "none"
      wmode: "window"
      useStateClassSkin: true
      autoBlur: false
      keyEnabled: true
