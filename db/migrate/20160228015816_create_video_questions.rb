class CreateVideoQuestions < ActiveRecord::Migration
  def change
    create_table :video_questions do |t|
      t.references :video, index: true, foreign_key: true
      t.text :question

      t.timestamps null: false
    end
  end
end
