module GamesHelper
	def get_apps
		apps, size = [], 1_000
	    Steam.apps.each do |app|
    	if Game.where(:appid => app.id).blank?
	    	apps << Game.new(name: app.name, appid: app.id) 
	    	if apps.size > size
	    		Game.import apps
	    		apps = []
	    	end
	    end
	end
    Game.import apps 
  	end
end
