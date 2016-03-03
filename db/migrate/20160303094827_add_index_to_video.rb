class AddIndexToVideo < ActiveRecord::Migration
  def change
  	add_index :videos, :url, unique: true
    add_index :videos, :ytv_id, unique: true
  end
end
