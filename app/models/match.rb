class Match < ActiveRecord::Base
  belongs_to :club
  belongs_to :category, class_name: 'MatchCategory'

  has_many :videos
  has_one :match_stat
end
