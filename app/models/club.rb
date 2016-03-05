class Club < ActiveRecord::Base
  belongs_to :country
  has_many :matches
  has_many :playlists
end
