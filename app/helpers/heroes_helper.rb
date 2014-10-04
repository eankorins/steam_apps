module HeroesHelper

	def hero_small_img(hero)
		name = hero.downcase.gsub(' ', '_')
		ENV["HERO_IMG_URL"] + name + "_sb.png"
	end

	def hero_large_img(hero)
		name = hero.downcase.gsub(' ', '_')
		ENV["HERO_IMG_URL"] + name + "_lg.png"
	end

end
