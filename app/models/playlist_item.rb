class PlaylistItem < ActiveRecord::Base
  belongs_to :stream
  validates :song, uniqueness: true, unless: :last_song_differs

  def last_song_differs
    self.stream.playlist_items.any? &&
      self.song != self.stream.playlist_items.last.song
  end
end
