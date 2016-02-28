class CreateClipQuestions < ActiveRecord::Migration
  def change
    create_table :clip_questions do |t|
      t.references :clip, index: true, foreign_key: true
      t.text :question

      t.timestamps null: false
    end
  end
end
