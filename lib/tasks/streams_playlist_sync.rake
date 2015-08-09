namespace :streams do
  namespace :playlists do
    desc "Rake task to sync streams playlists"
    task :sync => :environment do
      Stream.sync_playlists
    end
  end
end
