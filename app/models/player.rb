class Player < ActiveRecord::Base
	self.per_page = 30
	self.primary_key = 'steam_id'
	include PlayersHelper
	include ApplicationHelper

	after_create :get_profile
	
	has_many :playedgames, :dependent => :destroy
	has_many :games, :through => :playedgames
	has_many :completed_achievements, :dependent => :destroy
	has_many :achievements, :through => :completed_achievements
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	has_many :participations, :class_name => "Participant"
	has_many :matches, :through => :participations, :source => :match
	validates :steam_id, presence: true, uniqueness: {case_sensitive:false}

	scope :by_achievement_count, -> { joins(:playedgames).order(PlayedGame.by_achievement_count) }
	scope :by_time_played, -> { order(:total_time_played) }

	def account_id 
		self.steam_id.to_i - 76561197960265728
	end

	def to_steam_id(accid)
		accid + 76561197960265728
	end
	
	def total_time_played
		played_time = playedgames.sum(:playedtime)
	end

	def total_time_played_string
		played_time = total_time
		played_time_hours = (played_time / 60).round(2)
		played_time_days = (played_time_hours / 24).round(2)
		"#{played_time_hours.to_s} hrs (#{played_time_days.to_s} days)"
	end

	def game_ids
		games.map(&:game_id)
	end

	def player_games
		owned_games = Steam.owned_games(steamid: self.steam_id)

		owned_games.each  do | game |
			begin 
				puts game.id
				g = Game.find_by(appid: game.id)
				self.playedgames.create(game_id: g.id, playedtime: game.playtime_forever) unless game_ids.include?(g.id)
				update_time_played
			rescue
				"Not Found"
			end		
		end unless owned_games.nil?
	end

	def wins 
		participations.select{ |x| x.side.downcase == x.match.winner }.count
	end

	def get_profile
		profile = Steam.profile(self.steam_id)

		if profile 
			self.name = profile.person_name
			self.steam_id = profile.id
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
		player_games
	end
	def get_friends
		friends = Steam.friends(self.steam_id)

		unless friends.nil?
			friends.each do |f| 
				if player = Player.find_by(:steam_id => f.steam_id)
					unless self.friends.find_by(:steam_id => player.steam_id)
						self.friendships.create(:friend_id => player.id)
					end
				else
					p = Player.create(:steam_id => f.steam_id) 
					self.friendships.create(:friend_id => p.id )
					sleep(1)
				end		
			end
		end
	end

	def update_time_played
		self.total_time = playedgames.sum(:playedtime)
		save
	end

	def has_friends?
		self.friends.any?
	end
end
