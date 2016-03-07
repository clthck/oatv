class ClipPlayer < ActiveRecord::Base
  belongs_to :clip
  belongs_to :player
end
