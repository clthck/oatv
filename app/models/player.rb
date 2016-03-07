class Player < User
	default_scope -> { where(role: Role.find_by(name: 'player')) }
end