class DotaStats < ActiveRecord::Base
	belongs_to :player, :foreign_key => "player_id"
	has_one :hero, :class_name => "Hero", :foreign_key => "most_played_hero"

	def update_stats
		ws = player.wins
		ls = player.losses
		self.winning_kda = average_kda ws
		self.losing_kda = average_kda ls
		self.avg_kda = average_kda player.participations
		self.wins = ws.count
		self.losses = ls.count
		self.most_played_hero = highest_val(count_by(participations.map(&:hero_id)))
		self.most_played_mode = highest_val(count_by(participations.map{|x| x.match.mode}))
		self.most_played_with = highest_val(count_by(participations.map{|x| x.match.map{|p|p.player_id}}).flatten)
		self.radiant_matches = radiant_matches
		self.dire_matches = dire_matches

		self.save
	end


	def average_kda(participations)

		avg_kills = participations.map(&:kills).sum / participations.count
		avg_assists = participations.(&:assists).sum / participations.count
		avg_deaths = participations.(&:deaths).sum / participations.count
		[avg_kills, avg_assists, avg_deaths]
	end

	def most_played_hero
		count_by = participations.map(&:hero_id).inject({}){ |hash,key| hash += 1 }

		count_by.max_by{ |k,v| v}.key
	end

	def most_played_mode

	end


	def highest_val(hash)
		hash.max_by{ |k,v| v }.key
	end
	def count_by(arr)
		arr.inject({}){ |hash,key| hash += 1 }
	end
end
