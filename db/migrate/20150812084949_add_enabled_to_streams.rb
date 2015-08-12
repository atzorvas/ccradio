class AddEnabledToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :enabled, :boolean, default: false
  end
end
