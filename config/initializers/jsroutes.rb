JsRoutes.setup do |config|
	config.include = [
		/^matches_categories$/,
		/^datatables_editor_cud_matches_categories$/,
		/^matches$/,
		/^datatables_editor_cud_matches$/,
		/^edit_stats_match$/,
		/^stats_match$/,
		/^match_videos$/,
		/^clip_categories$/,
		/^datatables_editor_cud_clip_categories$/,
		/^datatables_editor_cud_match_video_clips$/,
		/^match_video_clips$/,
		/^playlists$/,
		/^datatables_editor_cud_playlists$/,
		/^playlist_clips$/,
		/^datatables_editor_cud_on_playlist_playlist_clips$/,
		/^players_clubs$/,
		/^update_yaybar_hidden_state_dashboard_index$/,
		/^conversations$/,
		/^conversation_messages$/,
	]
end