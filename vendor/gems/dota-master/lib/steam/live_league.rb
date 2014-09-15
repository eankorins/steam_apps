require 'steam/basic_player'
require 'steam/team'
require 'steam/utils/inspectable'

module Steam
  class LiveLeague
    include Utils::Inspectable
    attr_reader :raw_live_league

    # Initializes a new LiveLeague object
    #
    # @param raw_live_league [Hash]
    def initialize(raw_live_league)
      @raw_live_league = raw_live_league
    end

    # League id
    #
    # @return [Integer]
    def id
      raw_live_league['league_id']
    end

    # Lobby id
    #
    # @return [Integer]
    def lobby_id
      raw_live_league['lobby_id']
    end

    # A number of spectators
    #
    # @return [Integer]
    def spectators
      raw_live_league['spectators']
    end

    # A 22-bit uint detailing if each tower is alive
    #
    # @return [Integer]
    def tower_state
      raw_live_league['tower_state']
    end

    # Steam::Team object that represents
    # information about the dire's tournament team
    #
    # @return [Steam::Team]
    def dire
      @dire ||= Team.new(raw_live_league['dire_team'])
    end

    # Steam::Team object that represents
    # information about the radiant's tournament team
    #
    # @return [Steam::Team]
    def radiant
      @radiant ||= Team.new(raw_live_league['radiant_team'])
    end

    # Array of players
    #
    # @return [Array<Steam::LiveLeague::Player>] array of Steam::LiveLeague::Player objects
    def players
      raw_live_league['players'].map do |raw_player|
        Player.new(raw_player)
      end
    end

    class Player < Steam::BasicPlayer
      # Player's nickname
      #
      # @return [String]
      def name
        raw_player['name']
      end

      # Player's faction
      #
      # @return [Symbol] :dire, :radiant or :broadcaster
      def team
        case raw_player['team']
        when 0
          :radiant
        when 1
          :dire
        when 2
          :broadcaster
        end
      end
    end
  end
end
