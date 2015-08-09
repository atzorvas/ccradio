class Stream < ActiveRecord::Base
  has_many :playlist_items
  validates :title, :server, :mount, presence: true
  validates :title, uniqueness: true
  validates :mount, uniqueness: { scope: :server,
                                  message: "should exist once per server" }

  def self.sync_playlists
    Stream.all.each do |stream|
      stream.send(:sync_latest_song)
    end
    puts "Done"
  end

  def url
    self.get_url
  end

  def current_song
    self.get_last_song
  end

  protected

  def sync_latest_song
    require 'open-uri'
    page = open_url(self.get_url)
    song = get_current_song(page)
    @song = fix_song_title(song)
    # save it
    save_song if new_song?
  end

  def save_song
    self.playlist_items.create(song: @song)
  end

  def new_song?
    @song != get_last_song
  end

  def fix_song_title song
    song.gsub('_', ' ').gsub('-', ' - ')
  end

  def get_current_song(doc)
    doc.xpath('//td[contains(text(),"Current Song")]//following-sibling::td').text
  end

  def open_url url
    Nokogiri::HTML.parse(open(url).read)
  end

  def get_url
    URI.join(self.server, "status.xsl?mount=#{self.mount}").to_s
  end

  def get_last_song
    self.playlist_items.any? && self.playlist_items.last || nil
  end

end
