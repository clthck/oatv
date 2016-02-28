class Playlist < ActiveRecord::Base
  belongs_to :club

  has_many :playlist_clips
  has_many :clips, through: :playlist_clips
  
  has_many :playlist_questions
end
