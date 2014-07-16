require 'steam/app'
	
module Steam
	class OwnedApp < App
		def playtime_2weeks
	      rawp_app['playtime_2weeks'] 
	    end

	    # The time at which first blood occurred
	    #
	    # @return [Integer]
	    def playtime_forever
	      raw_app['playtime_forever']
	    end

	    # Array of players
	    #
	    # @return [Array<Steam::Match::Player>] array of Steam::Match::Player objects
	    def icon
	      raw_app['img_icon_url']
	    end

	    def logo 
	    	raw_app['img_logo_url']
	    	
	    end

	    def has_stats
	    	raw_app['has_community_visible_stats']
	    end
	end
end
