class CreateClipPlayers < ActiveRecord::Migration
  def change
    create_table :clip_players do |t|
      t.references :clip, index: true, foreign_key: true
      t.references :player, index: true, foreign_key: true, references: :users
      t.datetime :last_watched

      t.timestamps null: false
    end
  end
end
