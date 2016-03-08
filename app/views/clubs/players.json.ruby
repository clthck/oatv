players_hashes = @players.map do |player|
	{
		id: player.id,
		full_name: player.profile.full_name,
		avatar_url_thumb: player.profile.avatar.url(:thumb)
	}
end
{ data: players_hashes }.to_json