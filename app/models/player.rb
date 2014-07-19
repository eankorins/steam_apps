class Player < ActiveRecord::Base
	self.per_page = 30
	
	include PlayersHelper

	before_save :player_profile
	after_create :player_games

	has_many :playedgames, :dependent => :destroy
	has_many :games, :through => :playedgames
	has_many :completed_achievements, :dependent => :destroy
	has_many :achievements, :through => :completed_achievements
	
	validates :steamid, presence: true, uniqueness: {case_sensitive:false}

	scope :by_achievement_count, -> { joints(:playedgames).order(PlayedGame.by_achievement_count) }

	def player_games
		owned_games = Steam.owned_games(steamid: self.steamid)

		owned_games.each  do | game |
			begin 
				puts game.id
				g = Game.find_by(appid: game.id)
				self.playedgames.create(game_id: g.id, playedtime: game.playtime_forever)	
			rescue
				"Not Found"
			end		
		end
	end

	def player_profile
		profile = Steam.profile(self.steamid)

		if profile 
			self.name = profile.person_name
			self.steamid = profile.id
			self.real_name = profile.real_name
			self.clan_id = profile.clan_id
			self.country_code = profile.country_code
			self.state_code = profile.state_code
			self.created_at = profile.created_at
			self.access_state = profile.access_state
			self.configured = profile.configured?
			self.status = profile.status
			self.last_login = profile.last_login
			self.profile_url = profile.profile_url
			self.small_avatar = profile.small_avatar_url
			self.medium_avatar = profile.medium_avatar_url
			self.large_avatar = profile.big_avatar_url
			self.commentable = profile.commentable?
			self.current_game_id = profile.game_id
			self.current_game_title = profile.game_title
			self.current_game_server_ip = profile.game_server_ip
		end
	end
end
