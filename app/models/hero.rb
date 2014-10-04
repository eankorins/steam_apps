class Hero < ActiveRecord::Base
	include HeroesHelper

	self.primary_key = 'id'
	has_many :participations, :class_name => "Participant"
	has_many :players, -> {uniq}, :through => :participations, :source => :player

	def record
		"#{self.wins} / #{self.losses} AverageKDA: #{self.kda} Ratio: #{self.ratio}"
	end

	def get_wins 
		participations.select { |x| x.side.downcase == x.match.winner && x.match.lobby_type != "Co-op with bots" }
	end

	def get_losses
		participations.select{ |x| x.side.downcase != x.match.winner && x.match.lobby_type != "Co-op with bots"}
	end

	def ratio
		((self.kills + self.assists) / self.deaths).round(2)
	end

	def kda
		"#{self.kills.round(2)}/#{self.deaths.round(2)}/#{self.assists.round(2)}"
	end

	def average_kda
		count = participations.count.to_f

		avg_kills = (participations.map(&:kills).sum.to_f / count).round(2)
		avg_assists = (participations.map(&:assists).sum.to_f / count).round(2)
		avg_deaths = (participations.map(&:deaths).sum.to_f / count).round(2)
		[avg_kills, avg_deaths, avg_assists]
	end

	def update_stats
		self.wins = get_wins.count
		self.losses = get_losses.count
		self.kills, self.deaths, self.assists = average_kda.map!{ |x| x.round(2) }

		self.save
	end
end
