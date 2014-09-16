require 'steam'

module ApplicationHelper
	def to_match(match)
	{
		match_id: match.id, 
		match_seq_num: match.seq_num, 
		start_time: match.start, 
		lobby_type: match.lobby,
		winner: match.winner,
		first_blood: match.first_blood,
		duration: match.duration,
		season: match.season,
		human_players: match.human_players,
		positive_votes: match.positive_votes,
		negative_votes: match.negative_votes,
		cluster: match.cluster,
		mode: match.mode,
		league_id: match.league_id,
		radiant_tower_status: match.radiant_tower_status,
		dire_tower_status: match.radiant_tower_status,
		dire_barracks_status: match.dire_barracks_status,
		participants: match.players.map{ |p| Participant.new(to_player(p)) } 
	}
	end

	def to_player(player)
		{
			player_id: player.id + 76561197960265728,
			player_slot: player.slot,
			hero_id: player.hero_id, 
			kills: player.kills,
			deaths: player.deaths,
			assists: player.assists,
			kda: player.kda,
			leaver_status: player.leaver_status,
			gold: player.gold,
			last_hits: player.last_hits,
			denies: player.denies,
			gold_spent: player.gold_spent,
			hero_damage: player.hero_damage,
			tower_damage: player.tower_damage,
			hero_healing: player.hero_healing,
			level: player.level,
			xpm: player.xpm,
			gpm: player.gpm,
			items: player.items,
			additional_unit_items: player.additional_unit_items,
			additional_unit_names: player.additional_unit_names,
			upgrades: player.upgrades
		}
	end

	def to_steam_id(id)
		(id.to_i + 76561197960265728)
	end

	def to_account_id(id)

		id.to_i
	end
end
