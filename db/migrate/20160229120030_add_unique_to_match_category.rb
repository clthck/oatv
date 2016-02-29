class AddUniqueToMatchCategory < ActiveRecord::Migration
  def change
  	add_index :match_categories, :name, unique: true
  end
end
