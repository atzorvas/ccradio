class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :title
      t.string :server
      t.string :mount

      t.timestamps null: false
    end
  end
end
