class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :club, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true, references: :match_categories
      t.string :name
      t.date :date

      t.timestamps null: false
    end
  end
end
