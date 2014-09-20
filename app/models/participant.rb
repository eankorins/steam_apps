require 'steam'

class Participant < ActiveRecord::Base
	include ApplicationHelper 

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

	def hero_small_img
		name = hero.downcase.gsub(' ', '_')
		ENV["HERO_IMG_URL"] + name + "_sb.png"
	end

	def hero_large_img
		name = hero.downcase.gsub(' ', '_')
		ENV["HERO_IMG_URL"] + name + "_lg.png"
	end

	def item_small_img(item)
		ENV["ITEM_IMG_URL"] + item + "_eg.png"
	end
end
