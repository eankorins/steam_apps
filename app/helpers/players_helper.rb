module PlayersHelper
	
	def findnil(id)
		player = Player.find(params[:steamid])
		owned_games = Steam.owned_games(steamid: id)

		owned_games.each  do | game |
			puts game.id	
			sleep(1)
		end
	end
		def hero_list
		(1..110).map do |i|
			[Steam::Constants::Heroes[i], i]
		end - [nil]
	end
end
