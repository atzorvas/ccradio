# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  page = this
  $(document).on "show", (e) ->
    page.visible = true
  $(document).on "hide", (e) ->
    page.visible = false

  body = $ "body"
  action = body.attr 'data-action'
  if action == 'index'
    console.log "index loaded"
    setInterval ->
      if page.visible
        $("table tbody tr").each ->
          $.ajax(
            url: $(this).attr 'data-url'
            dataType: 'json'
            stream = $(this)
          ).done (data) ->
            song = $(stream).find('td.song')
            text = song.text().trim()
            if text != data.song # only append if song is different
              song.text data.song
    , 2000
    true
  if action == "show"
    setInterval ->
      if page.visible
        $.ajax(
          url: $("table.station-info").attr 'data-url'
          dataType: 'json'
          stream = $(this)
        ).done (data) ->
          song = $("table.playlist tbody tr:nth-child(1) td:nth-child(1)")
          text = song.text().trim()
          if text != data.song # only append if song is different
            console.log("changed")
            $("table.playlist").prepend('<tr><td>'+data.song+'</td><td>'+data.created_at+'</td></tr>')
    , 2000
    true
