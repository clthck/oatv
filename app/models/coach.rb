class Coach < User
	default_scope -> { where(role: Role.find_by(name: 'coach')) }
end