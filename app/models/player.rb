class Player < ActiveRecord::Base
	self.per_page = 30
	self.primary_key = 'account_id'
	include PlayersHelper
	include ApplicationHelper

	after_create :save_player
	has_many :playedgames, :dependent => :destroy
	has_many :games, :through => :playedgames
	has_many :participations, :class_name => "Participant"
	has_many :heroes, -> {uniq},  :through => :participations, :source => :hero
	has_many :matches, :through => :participations, :source => :match
	has_many :dota_stats, :class_name => "DotaStats"
	validates :account_id, presence: true, uniqueness: {case_sensitive:false}

	scope :by_achievement_count, -> { joins(:playedgames).order(PlayedGame.by_achievement_count) }
	scope :by_time_played, -> { order(:total_time_played) }

	def acc_id 
		to_account_id(self.account_id)
	end

	def steam_id
		to_steam_id self.account_id
	end
	
	def to_acc_id 
		self.account_id = acc_id
		puts acc_id
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
		if Game.any? 
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
	end

	def hero_matches(id)
		matches = self.participations.select { |p| p.hero_id == id}
		matches
	end


	def wins 
		participations.select{ |x| x.side.downcase == x.match.winner && x.match.lobby_type != "Co-op with bots"}
	end

	def total_wins
		wins.count
	end

	def losses
		participations.select{ |x| x.side.downcase != x.match.winner && x.match.lobby_type != "Co-op with bots"}
	end

	def radiant_matches
		participations.select { |x| x.side.downcase == "radiant" }
	end

	def dire_matches
		participations.select { |x| x.side.downcase == "dire" }
	end

	def record
		"#{total_wins} - #{participations.count - total_wins}"
	end
	
	def get_profile
		profile = Steam.profile(self.steam_id) if name.nil?
	end

	def save_player(profile = nil)
		profile = get_profile if profile.nil?
		self.dota_stats.create
		if profile 
			self.name = profile.person_name
			self.real_name = profile.real_name
			self.clan_id = profile.clan_id.to_s
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
		self.save
		player_games
	end

	def get_friends
		friends = Steam.friends(self.steam_id)

		unless friends.nil?
			friends.each do |f| 
				if player = Player.find_by(:account_id => to_account_id(f.steam_id))
					unless self.friends.find_by(:account_id => player.account_id)
						self.friendships.create(:friend_id => player.id)
					end
				else
					p = Player.create(:account_id => to_account_id(f.steam_id)) 
					self.friendships.build(:friend_id => p.id)
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
