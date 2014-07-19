class Playedgame < ActiveRecord::Base
	self.per_page = 30
	
	belongs_to :player
	belongs_to :game

	scope :by_name, -> { joins(:game).order('games.name') }
	scope :by_achievement_count, -> { joins(:game).order('games.achievements_count DESC')}
end
