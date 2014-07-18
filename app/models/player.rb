class Player < ActiveRecord::Base
	include PlayersHelper
	after_create :player_games
	has_many :playedgames, :dependent => :destroy
	has_many :games, :through => :playedgames

	def player_games
		owned_games = Steam.owned_games(steamid: self.steamid)

		owned_games.each  do | game |
			puts game.id
			g = Game.find_by(appid: game.id)
			self.playedgames.create(game_id: g.id, playedtime: game.playtime_forever)			
		end
	end
end
