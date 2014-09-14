require 'Steam'

class Participant < ActiveRecord::Base
	belongs_to :match
	belongs_to :player, :class_name => "Player", :foreign_key => "player_id"

	def hero
		Steam::Constants::Heroes[self.hero_id]
	end

	def winner
		self.match.winner == side.downcase ? "winner" : "loser"
	end

	def side 
		self.player_slot < 5 ? "Radiant" : "Dire"
	end
end
