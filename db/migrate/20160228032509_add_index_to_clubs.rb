class AddIndexToClubs < ActiveRecord::Migration
  def change
  	add_index :clubs, [:name, :country_id], unique: true
  end
end
