class Game < ActiveRecord::Base
	self.per_page = 30
	
	has_many :playedgames, :dependent => :destroy
	has_many :players, :through => :playedgames
	has_many :achievements, :dependent => :destroy
	has_many :stats, :dependent => :destroy

	after_create :get_scheme

	scope :by_achievement_count, -> { order('achievements_count DESC') }
	scope :by_stats_count, -> { order('stats_count desc') }
	scope :with_stats, -> { where('stats_count > 0') }
	scope :with_achievements, -> { where('achievements_count > 0') }
	scope :by_name, -> { order(:name) }
	
end
