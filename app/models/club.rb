class Club < ActiveRecord::Base
  belongs_to :country
  has_many :matches
  has_many :playlists
  has_many :users
  has_many :players
  has_many :coaches
end
