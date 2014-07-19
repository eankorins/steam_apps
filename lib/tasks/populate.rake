namespace :db do
	desc "Fill db with steam apps"
	task get_games: :environment do
		apps = get_apps
	end
	task get_player: :environment do
		user = Player.create(steamid: "76561197963000940", name: "Furryballs")
	end
end


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