require "#{Rails.root}/app/helpers/application_helper.rb"
include ApplicationHelper
namespace :db do
	desc "Fill db with steam apps"
	task get_games: :environment do
		apps = get_apps
	end
	task get_player: :environment do
		user = Player.create(account_id: to_account_id(76561198101298200) )
	end

	task get_all_games: :environment do
		get_matches_by_sequence
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

def get_matches_by_sequence
	max_seq = 0
	max_seq = Match.all.map(&:match_seq_num).max unless Match.first.blank? 
	total_time_run = 0
	total_games_added = 0
	begin 
		start = Time.now
		matches = []
		begin 
			sequence = Steam.history_sequence(start_at_match_seq_num: (max_seq + 1))
			max_seq = sequence.map(&:seq_num).max
			matches << sequence.map { |m| to_match(m) }
		end until matches.count == 20
		time = Time.now - start
		total_time_run += time
		puts time.to_s << " seconds to retrieve " << (matches.count * 100).to_s

		start = Time.now
		ActiveRecord::Base.transaction do
			matches.flatten.each { |m| Match.create(m) }
		end 
		total_games_added += matches.flatten.count
		time = Time.now - start
		total_time_run += time
		puts  time.to_s << " seconds to insert"


		puts "time run: " << total_time_run.to_s << " total games added: " << total_games_added.to_s
	end until sequence.count == 0	
end
