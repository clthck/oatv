class CreateMatchCategories < ActiveRecord::Migration
  def change
    create_table :match_categories do |t|
      t.string :name
    end
  end
end
