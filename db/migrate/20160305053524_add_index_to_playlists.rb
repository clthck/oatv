class AddIndexToPlaylists < ActiveRecord::Migration
  def change
  	add_index :playlists, [:club_id, :name], unique: true
  end
end
