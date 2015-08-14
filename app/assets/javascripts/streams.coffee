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

  if action == "show"
    stream_id = parseInt($(".station-info").attr('stream-id'))
    socket.onmessage = (event) ->
      if event.data.length
        song = JSON.parse(event.data).song
        if song.stream_id == stream_id
          te = $("<tr><td>#{song.song}</td><td>#{song.created_at}</td></tr>")
          te.hide()
          $("table.playlist").prepend(te)
          te.fadeIn 500
