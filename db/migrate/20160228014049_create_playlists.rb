class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.references :club, index: true, foreign_key: true
      t.string :name
    end
  end
end
