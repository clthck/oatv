class CreateMatchStats < ActiveRecord::Migration
  def change
    create_table :match_stats do |t|
      t.references :match, index: true, foreign_key: true
      t.integer :shots_on_goals
      t.integer :corners
      t.integer :goals
    end
  end
end
