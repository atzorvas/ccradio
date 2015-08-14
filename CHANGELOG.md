## v0.2.0

###### New:
- Added some style; thanks to Dimitris Kourouvakalis
- Replaced expensive ajax-calls with Websockets (Tubesock & Redis) on server
  for real-time updates on playling status

## v0.1.0
*Hello World* release!

###### New:
- Basic auth, only admin can create/edit/destroy streams.
- Async background job every 5sec to update stream playlist info if needed
- Ajax-solution for auto-updating content related to "now playing song" and
  "playlist info".
  - DOM updates only when needed (ex; new song is being played)
  - Page Visibility API is being used, so to avoid ajax calls that when page
    doesn't have focus on browser
- basic audio html5 tag in order to listen each stream
- slim-rails is being used for templating
- db seeds for streams (currently loading creativecommons.gr [stations](http://stream.creativecommons.gr:8000/status.xsl)
