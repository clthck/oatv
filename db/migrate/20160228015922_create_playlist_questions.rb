class CreatePlaylistQuestions < ActiveRecord::Migration
  def change
    create_table :playlist_questions do |t|
      t.references :playlist, index: true, foreign_key: true
      t.text :question

      t.timestamps null: false
    end
  end
end
