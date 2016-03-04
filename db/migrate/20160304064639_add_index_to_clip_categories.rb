class AddIndexToClipCategories < ActiveRecord::Migration
  def change
  	add_index :clip_categories, :name, unique: true
  end
end
