class Match < ActiveRecord::Base
	has_many :participants, :dependent => :destroy
	has_many :players, :through => :participants
	accepts_nested_attributes_for :participants, :allow_destroy => true

	def radiant 
		self.participants.select{|x| x.player_slot < 5}
	end

	def dire
		self.participants.select{|x| x.player_slot > 5}
	end
	
end
