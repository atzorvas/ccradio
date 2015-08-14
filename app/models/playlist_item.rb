class PlaylistItem < ActiveRecord::Base
  belongs_to :stream
  validates :song, uniqueness: true, unless: :last_song_differs
  after_create :notify

  def notify
    $redis.publish "songs", { song: self }.to_json
  end

  def last_song_differs
    stream.playlist_items.any? &&
      song != stream.playlist_items.last.song
  end
end
