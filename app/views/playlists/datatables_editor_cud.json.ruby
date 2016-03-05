if @json_data[:data] and @json_data[:data][0]
	playlists_hashes = @json_data[:data].map do |playlist|
		playlist.as_json.merge({ clips_count: playlist.clips.count })
	end
	{ data: playlists_hashes }.to_json
else
	@json_data.to_json
end
