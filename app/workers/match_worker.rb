
class MatchWorker
	include Sidekiq::Worker
	include ApplicationHelper
	def perform(id)
		begin
			player = Player.find(id)
			puts "Running"
			all_matches = []
			min_id = 1
			begin
				history = Steam.history({ account_id: player.account_id, start_at_match_id: min_id - 1 })
				all_matches << history.matches 
				puts history.remaining_count.to_s << " remaining"
				min_id = history.matches.map(&:id).min 

			end until history.remaining_count == 0 

			all_matches.flatten.each do |m|
				if Match.find_by(:match_id => m.id).blank?
					m = Match.new(to_match(Steam.match(m.id)))
					m.save
					sleep(1)
				end
			end

			player.dota_stats.first.update_stats
			puts "Done"
		rescue Exception => ex
			puts "Broken"
			puts ex.message
		end
	end
end