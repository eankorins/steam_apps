class DotaStats < ActiveRecord::Base
	belongs_to :player, :foreign_key => "player_id"
	has_many :participations, :through => :player, :source => :participations
	has_one :hero, :class_name => "Hero", :foreign_key => "most_played_hero"

	def update_stats
		ws = player.wins
		ls = player.losses
		self.winning_kda = average_kda(ws)
		self.losing_kda = average_kda(ls)
		self.avg_kda = average_kda(participations)
		self.wins = ws.count
		self.losses = ls.count
		self.most_played_hero = most_hero
		self.most_played_mode = most_mode
		self.most_played_with = most_with
		self.radiant_matches = player.radiant_matches.count
		self.dire_matches = player.dire_matches.count

		self.save
	end


	def average_kda(parts)

		count = parts.count.to_f

		avg_kills = (participations.map(&:kills).sum.to_f / count).round(2)
		avg_assists = (participations.map(&:assists).sum.to_f / count).round(2)
		avg_deaths = (participations.map(&:deaths).sum.to_f / count).round(2)
		"#{avg_kills}/#{avg_deaths}/#{avg_assists}"
	end

	def most_mode
		mode, count = max_by(count_by(participations.map{|x| x.match.mode}))
		"#{mode} (#{count})"
	end

	def most_hero
		hero, count = max_by(count_by(participations.map(&:hero_id)))
		hero = Hero.find_by(:id => hero).name
		"#{hero} (#{count})"
	end

	def most_with
		played_with = player.matches.map { |x| x.participants }.flatten.map! { |x| x.player_id }
		played_with = played_with - [player.account_id, "4294967295", "0"]
		player, count = max_by(count_by(played_with))
		p = Player.find_by(:account_id => player)
		name = p.nil? ? player : p.name
		"#{name} (#{count})"
	end

	def max_by(hash)
		key, count = hash.max_by{ |k,v| v }
		[key, count]
	end

	def count_by(arr)
		(arr).inject(Hash.new(0)){ |hash,key| hash[key] += 1; hash}
	end
end
