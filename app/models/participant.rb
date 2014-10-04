require 'steam'

class Participant < ActiveRecord::Base
	include ApplicationHelper 
	include HeroesHelper
	belongs_to :match
	belongs_to :player, :class_name => "Player", :foreign_key => "player_id"
	belongs_to :hero

	def hero
		Steam::Constants::Heroes[self.hero_id]
	end

	def winner
		self.match.winner == side.downcase ? "winner" : "loser"
	end

	def side 
		self.player_slot < 5 ? "Radiant" : "Dire"
	end
	
	def item_imgs
		items = self.items.split(' ').select { |item| not item.include?('empty')}
		items.map { |item| item_small_img(item)}
	end

	def item_small_img(item)
		ENV["ITEM_IMG_URL"] + item + "_eg.png"
	end
end
