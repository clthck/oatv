class PlaylistClip < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :clip
end
