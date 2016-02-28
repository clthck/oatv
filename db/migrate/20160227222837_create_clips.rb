class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.references :video, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true, references: :clip_categories
      t.string :name
      t.integer :start
      t.integer :end
      t.references :player, index: true, foreign_key: true, references: :users

      t.timestamps null: false
    end
  end
end
