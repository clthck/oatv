{ data: @clips.as_json(
	include: [
		:category,
		video: {
			include: :match
		}
	])
}.to_json