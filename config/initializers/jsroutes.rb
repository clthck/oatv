JsRoutes.setup do |config|
	config.include = [
		/^matches_categories$/,
		/^datatables_editor_cud_matches_categories$/,
		/^matches$/,
		/^datatables_editor_cud_matches$/,
		/^stats_match$/,
		/^match_videos$/,
		/^clip_categories$/,
		/^datatables_editor_cud_clip_categories$/,
	]
end