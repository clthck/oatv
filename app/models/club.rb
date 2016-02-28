class Club < ActiveRecord::Base
  belongs_to :country, class_name: 'Oatv::Country'
  has_many :matches
  has_many :playlists
end
