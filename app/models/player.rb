class Player < User
	default_scope -> { where(role: Role.find_by(name: 'player')) }
	
	has_many :clip_players
	has_many :clips, through: :clip_players
end