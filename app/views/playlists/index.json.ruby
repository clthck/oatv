playlists_hashes = @playlists.map do |playlist|
	playlist.as_json.merge({ clips_count: playlist.clips.count })
end
{ data: playlists_hashes }.to_json
