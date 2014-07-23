class Player < ActiveRecord::Base
	self.per_page = 30
	
	include PlayersHelper

	before_save :get_profile
	after_create :player_games

	has_many :playedgames, :dependent => :destroy
	has_many :games, :through => :playedgames
	has_many :completed_achievements, :dependent => :destroy
	has_many :achievements, :through => :completed_achievements
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	validates :steamid, presence: true, uniqueness: {case_sensitive:false}

	scope :by_achievement_count, -> { joins(:playedgames).order(PlayedGame.by_achievement_count) }
	scope :by_time_played, -> { order(:total_time_played) }

	def total_time_played
		played_time = playedgames.sum(:playedtime)
	end
	def total_time_played_string
		played_time = total_time_played
		played_time_hours = (played_time / 60).round(2)
		played_time_days = (played_time_hours / 24).round(2)
		"#{played_time_hours.to_s} hrs (#{played_time_days.to_s} days)"
	end
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
		end unless owned_games.nil?
	end
	def get_profile
		profile = Steam.profile(self.steamid)

		if profile 
			self.name = profile.person_name
			self.steamid = profile.id
			self.real_name = profile.real_name
			self.clan_id = profile.clan_id
			self.country_code = profile.country_code
			self.state_code = profile.state_code
			self.profile_created_at = profile.created_at
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
	def get_friends
		friends = Steam.friends(self.steamid)

		if friends.any?
			friends.each do |f| 
				if player = Player.find_by(:steamid => f.steam_id)
					unless self.friends.find_by(:steamid => player.steamid)
						self.friendships.create(:friend_id => player.id)
					end
				else
					p = Player.create(:steamid => f.steam_id) 
					self.friendships.create(:friend_id => p.id )
					sleep(1)
				end		
			end
		end
	end
end
