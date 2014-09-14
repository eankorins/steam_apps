require 'steam/constants/heroes'
require 'steam/utils/inspectable'

module Steam
  class BasicPlayer
    include Utils::Inspectable
    attr_reader :raw_player

    # Initializes a new Player object
    #
    # @param raw_player [Hash]
    def initialize(raw_player)
      @raw_player = raw_player
    end

    # The player's Steam ID
    #
    # @return [Integer]
    def id
      i = raw_player['account_id']
      if i.nil?
        0
      else
        i
      end
    end

    # Player's slot. If the left-most bit is set, the player was on dire
    #
    # @return [Integer]
    def slot
      raw_player['player_slot']
    end

    # The ID of the hero that the player used
    #
    # @return [Integer]
    def hero_id
      raw_player['hero_id']
    end

    # Hero name
    #
    # @ return [String]
    def hero
      Constants::Heroes[hero_id]
    end
  end
end
