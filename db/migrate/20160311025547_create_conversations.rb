class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
    	t.references :sender, foreign_key: true, index: true, references: :users
    	t.references :recipient, foreign_key: true, index: true, references: :users

      t.timestamps null: false
    end
  end
end
