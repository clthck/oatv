class AddClubRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :club, index: true, foreign_key: true
  end
end
