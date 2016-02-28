class CreateClipCategories < ActiveRecord::Migration
  def change
    create_table :clip_categories do |t|
      t.string :name
    end
  end
end
