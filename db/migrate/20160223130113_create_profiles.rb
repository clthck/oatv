class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :full_name
      t.date :birthday
      t.string :gender
      t.text :introduction
      t.attachment :avatar
    end
  end
end
