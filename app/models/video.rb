class Video < ActiveRecord::Base
  belongs_to :match
  has_many :clips
  has_many :video_questions
end
