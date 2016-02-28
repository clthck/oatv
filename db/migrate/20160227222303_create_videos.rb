class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.references :match, index: true, foreign_key: true
      t.string :url
      t.string :ytv_id, foreign_key: false
      t.string :title
      t.integer :duration
      t.string :thumbnail_url

      t.timestamps null: false
    end
  end
end
