class Moment

	# Convert duration to number of seconds
	# Supported formats:
	# 	[HH:]mm:ss,SSS
	# 	HH:mm:ss
	# 	HHmmss
	def self.to_seconds(time, preserve = true)
		time_s = time.to_s
		if 		m = time_s.match(/(?:(\d+):)?(\d+):(\d+),\d{3}/)\
			or 	m = time_s.match(/^(\d+):(\d+):(\d+)$/)\
			or 	m = time_s.match(/^(\d{2})(\d{2})(\d{2})$/)
			m[1].to_i * 3600 + m[2].to_i * 60 + m[3].to_i
		else
			preserve ? time : 0
		end
	end

end