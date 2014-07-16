module PlayersHelper
	def player_games(id)
		player = Player.find(params[:id])
		owned_games = Steam.owned_games(steamid: id)

		owned_games.each  do | game |
			puts game.id
			g = Game.find_by(appid: game.id)
			player.playedgames.create(game_id: g.id, playedtime: game.playtime_forever)			
		end
	end
	def findnil(id)
		player = Player.find(params[:steamid])
		owned_games = Steam.owned_games(steamid: id)

		owned_games.each  do | game |
			puts game.id	
			sleep(1)
		end
	end
end
