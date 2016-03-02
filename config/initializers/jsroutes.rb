JsRoutes.setup do |config|
	config.include = [
		/^matches_categories$/,
		/^datatables_editor_cud_matches_categories$/,
		/^matches$/,
		/^datatables_editor_cud_matches$/,
		/^stats_match$/,
	]
end