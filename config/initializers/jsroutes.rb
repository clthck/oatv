JsRoutes.setup do |config|
	config.include = [
		/^matches_categories$/,
		/^matches__index$/,
		/^stats_matches_$/,
	]
end