class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.references :country, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
