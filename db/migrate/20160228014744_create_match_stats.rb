class CreateMatchStats < ActiveRecord::Migration
  def change
    create_table :match_stats do |t|
      t.references :match, index: true, foreign_key: true
      t.integer :goals_h
      t.integer :goals_a
      t.integer :total_shots_h
      t.integer :total_shots_a
      t.integer :shots_on_target_h
      t.integer :shots_on_target_a
      t.integer :completed_passes_h
      t.integer :completed_passes_a
      t.integer :passing_accuracy_h
      t.integer :passing_accuracy_a
      t.integer :possession_h
      t.integer :corners_h
      t.integer :corners_a
      t.integer :offsides_h
      t.integer :offsides_a
      t.integer :fouls_conceded_h
      t.integer :fouls_conceded_a
    end
  end
end
