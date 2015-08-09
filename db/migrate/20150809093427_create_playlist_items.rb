class CreatePlaylistItems < ActiveRecord::Migration
  def change
    create_table :playlist_items do |t|
      t.references :stream, index: true, foreign_key: true
      t.string :song

      t.timestamps null: false
    end
  end
end
