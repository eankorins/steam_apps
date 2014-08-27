class Playedgame < ActiveRecord::Base
	self.per_page = 30
	
	belongs_to :player, counter_cache: true
	belongs_to :game, counter_cache: true

	scope :by_name, -> { joins(:game).order('games.name') }
	scope :by_achievement_count, -> { joins(:game).order('games.achievements_count DESC')}
	scope :by_time_played, -> { order('playedtime DESC')}

	def update_time_played
		self.player.update_time_played
	end
end
