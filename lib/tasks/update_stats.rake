namespace :stats do
	task update_heroes: :environment do 
		Hero.all.each do |hero|
			hero.update_stats
		end
	end
end