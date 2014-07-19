class Achievement < ActiveRecord::Base
	self.per_page = 5
	belongs_to :game, counter_cache: true
	scope :by_name, -> { order(:name) }
	scope :hidden, -> { where(:hidden => 1) }
end
