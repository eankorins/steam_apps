class CompletedAchievement < ActiveRecord::Base
	self.per_page = 30
	belongs_to :player
	belongs_to :achievement
end
