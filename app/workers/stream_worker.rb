class StreamWorker
  include Sidekiq::Worker

  def perform
    Stream.sync_playlists
  end
end
