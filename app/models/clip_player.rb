class ClipPlayer < ActiveRecord::Base
  belongs_to :clip
  belongs_to :player, class_name: 'User', ->(user) { user.is?(:player) }
end
