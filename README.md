# CCradio App

[![Build Status](https://travis-ci.org/atzorvas/ccradio.svg)](https://travis-ci.org/atzorvas/ccradio) [![Code Climate](https://codeclimate.com/github/atzorvas/ccradio/badges/gpa.svg)](https://codeclimate.com/github/atzorvas/ccradio) [![Test Coverage](https://codeclimate.com/github/atzorvas/ccradio/badges/coverage.svg)](https://codeclimate.com/github/atzorvas/ccradio/coverage) [![Dependency Status](https://gemnasium.com/atzorvas/ccradio.svg)](https://gemnasium.com/atzorvas/ccradio) [![security](https://hakiri.io/github/atzorvas/ccradio/master.svg)](https://hakiri.io/github/atzorvas/ccradio/master)

---

## About
- Inspired by [ccradio.ellak.gr](https://ccradio.ellak.gr/), as the codebase of the original app was old and difficult to update, and because I love Rails, I decided to start this app as a replacement.  

## Info
- Version 0.1.0  
- project status: under active development  
- demo site: http://ccradio.tzorvas.com/  

## TODO
- [ ] Apply some styling <small>I know it's ugly, but this isn't my main concern for the time being</small>
- [ ] Add Suggest Stream Form (Github API)
- [ ] Add Feedback Form (Github API)
- [ ] Audio player @home screen (currently only in each station page)
 - [ ] Better-looking player
- [ ] Add integration tests
- [ ] Public API
- [ ] Crawler / Automated process to search for new streams with CC-friendly content
- [suggest another](https://github.com/atzorvas/ccradio/issues/new)

## Contribute
- [suggest](https://github.com/atzorvas/ccradio/issues/new) ideas or [report](https://github.com/atzorvas/ccradio/issues/new) any problems
- [Fork](https://github.com/atzorvas/ccradio/edit/master/README.md#fork-destination-box), develop and create a [Pull Request](https://github.com/atzorvas/ccradio/compare) if you want
- Suggest a new station creating an [issue](https://github.com/atzorvas/ccradio/issues/new) - or later via the site.

## Software Stack
- Rails ofc.
- Redis

## Gems
- Nokogiri for parsing stream data (current song)
- Sidekiq & Sidekiq-scheduler for delayed jobs and background tasks (with Redis server)
- jquery-visibility-rails (Page Visibility API wrapper; when document isn't focused, there is no need to auto-update "now playing" content)
- slim-rails for html templates
- Devise for authentication stuff

## License
Licensed under MIT license. 
