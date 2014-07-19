class Stat < ActiveRecord::Base
	self.per_page = 30
	
	belongs_to :game, counter_cache: true
	belongs_to :player_stat
end
