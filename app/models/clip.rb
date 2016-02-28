class Clip < ActiveRecord::Base
  belongs_to :video
  belongs_to :category, class_name: 'ClipCategory'

  has_many :clip_players
  has_many :players, through: :clip_players

  has_many :playlist_clips
  has_many :playlists, through: :playlist_clips

  has_many :clip_questions
end
