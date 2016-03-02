class ClipPlayer < ActiveRecord::Base
  belongs_to :clip
  belongs_to :player, ->(user) { user.is?(:player) }, class_name: 'User'
end
