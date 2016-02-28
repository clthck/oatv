class CreatePlaylistClips < ActiveRecord::Migration
  def change
    create_table :playlist_clips do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :clip, index: true, foreign_key: true
    end
  end
end
