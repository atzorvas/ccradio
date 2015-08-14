class PlaylistItem < ActiveRecord::Base
  belongs_to :stream
  validates :song, uniqueness: true, unless: :last_song_differs
  after_create {|item| item.notify }

  def notify
    $redis.publish 'songs', { song: self }.to_json
  end

  def last_song_differs
    self.stream.playlist_items.any? &&
      self.song != self.stream.playlist_items.last.song
  end
end
