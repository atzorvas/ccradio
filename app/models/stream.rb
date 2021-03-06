class Stream < ActiveRecord::Base
  has_many :playlist_items
  validates :title, :server, :mount, presence: true
  validates :title, uniqueness: true
  validates :mount, uniqueness: { scope: :server,
                                  message: "should exist once per server" }
  scope :enabled, -> { where(enabled: true) }

  def url_status # returns full url
    self.get_url_status
  end

  def url_play
    self.get_url_play
  end

  def self.sync_playlists
    enabled.map(&:sync_latest_song)
  end

  def sync_latest_song
    require 'open-uri'
    page = open_url(self.get_url_status)
    song = get_current_song(page)
    @song = fix_song_title(song)
    save_song
  end

  protected

  def save_song
    self.playlist_items.create(song: @song)
  end

  def fix_song_title song
    song.gsub('_', ' ').gsub('-', ' - ')
  end

  def get_current_song doc
    doc.xpath('//td[contains(text(),"Current Song")]//following-sibling::td').text
  end

  def open_url url
    Nokogiri::HTML.parse open(url).read
  end

  def get_url_status
    URI.join(self.server, "status.xsl?mount=#{self.mount}").to_s
  end

  def get_url_play
    URI.join(self.server, self.mount).to_s
  end

end
