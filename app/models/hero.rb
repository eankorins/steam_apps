class Hero < ActiveRecord::Base
	self.primary_key = 'id'
	has_many :participations, :class_name => "Participant"
	has_many :players, -> {uniq}, :through => :participations, :source => :player
end
