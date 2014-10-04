class Hero < ActiveRecord::Base
	include HeroesHelper

	self.primary_key = 'id'
	has_many :participations, :class_name => "Participant"
	has_many :players, -> {uniq}, :through => :participations, :source => :player

	def record
		"#{wins.count} / #{losses.count} AverageKDA: "
	end

	def wins 
		participations.select { |x| x.side.downcase == x.match.winner && x.match.lobby_type != "Co-op with bots" }
	end

	def losses
		participations.select{ |x| x.side.downcase != x.match.winner && x.match.lobby_type != "Co-op with bots"}
	end

	def average_kda
		count = participations.count.to_f

		avg_kills = (participations.map(&:kills).sum.to_f / count).round(2)
		avg_assists = (participations.map(&:assists).sum.to_f / count).round(2)
		avg_deaths = (participations.map(&:deaths).sum.to_f / count).round(2)
		"#{avg_kills}/#{avg_deaths}/#{avg_assists}"
	end

	def update_stats
		self.wins = wins.count
		self.losses = losses.count
		self.kda = average_kda

		self.save
	end
end
