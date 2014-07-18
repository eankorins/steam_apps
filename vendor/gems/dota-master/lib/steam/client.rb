require 'steam/configuration'
require 'steam/connection'

require 'steam/match'
require 'steam/league'
require 'steam/live_league'
require 'steam/history'
require 'steam/profile'
require 'steam/ban'
require 'steam/friend'
require 'steam/owned_app'
require 'steam/game_scheme'

module Steam
  class Client
    attr_reader :config

    VERSIONS = { 1 => 'V001', 2 => 'V002' }.freeze

    def initialize(options = {})
      @config = Configuration.new(options)
    end

    def configure
      yield config
    end

    def connection
      @connection ||= Connection.new
    end

    # Match details
    #
    # @param [Integer] match id
    # @return [Steam::Match] match object
    def match(id)
      response = run_request('GetMatchDetails', match_id: id)['result']
      Match.new(response) if response
    end

    # The list of matches played
    #
    # @return [Steam::History] match object
    def history(options = {})
      response = run_request('GetMatchHistory', options)['result']
      History.new(response) if response && response['result']
    end

    # All leagues list
    #
    # @return [Steam::League] league object
    def leagues(options = {})
      response = run_request('GetLeagueListing', options)['result']

      if response && (leagues = response['leagues'])
        leagues.map { |league| League.new(league) }
      end
    end

    # All live leagues list
    #
    # @return [Steam::League] league object
    def live_leagues(options = {})
      response = run_request('GetLiveLeagueGames', options)['result']

      if response && (leagues = response['games'])
        leagues.map { |league| LiveLeague.new(league) }
      end
    end

    # A list of Profile objects.
    # Contained information varies depending on whether or not the user
    # has their profile set to Friends only or Private
    #
    # @param [Integer] SteamId
    #
    # @return [Array<Steam::Profile>] an array of profile objects
    def profiles(*ids)
      response = run_request('GetPlayerSummaries', { steamids: ids.join(',') }, 'ISteamUser', VERSIONS[2])['response']

      if response && (profiles = response['players'])
        profiles.map { |profile| Profile.new(profile) }
      end
    end

    # Profile object
    #
    # @param [Integer] SteamId
    #
    # @return [<Steam::Profile>] profile for given id
    def profile(id)
      profiles = profiles(id)
      profiles && profiles.first
    end

    # List of player ban objects for each given (and valid) 64 bit ID.
    #
    # @param [Integer] SteamId
    # @return [Array<Steam::Ban>] an array of player's bans
    def bans(*ids)
      response = run_request('GetPlayerBans', { steamids: ids.join(',') }, 'ISteamUser')

      if response && (bans = response['players'])
        bans.map { |ban| Ban.new(ban) }
      end
    end

    # List of player's friends
    #
    # @param [Integer] SteamId
    # @return [Array<Steam::Friend>] an array of player's friends
    def friends(id = '1')
      response = run_request('GetFriendList', { steamid: id }, 'ISteamUser')

      if response && (friends = response['friendslist']['friends'])
        friends.map { |friend| Friend.new(friend) }
      end
    end
    def game_scheme(id)
      response = run_request('GetSchemaForGame', { appid: id}, 'ISteamUserStats', VERSIONS[2])

      if response && (available_stats = response['game']['availableGameStats'])
        GameScheme.new(available_stats)
      end
    end
    #List of apps available on steam
    #
    #@return [Array<Steam::App>] an array of apps
    def apps
      response = run_request('GetAppList', {}, 'ISteamApps', VERSIONS[2])
      if response && (apps = response['applist']['apps'])
        apps.map { |app| App.new(app)  }
      end
    end

    def owned_games(options = {})
      response = run_request('GetOwnedGames', options, 'IPlayerService', 'v1')
      if response && (games = response['response']['games'])
        games.map { |game| OwnedApp.new(game) }
      end
    end

    # @private
    def run_request(method, options = {}, interface = 'IDota2Match_570', api_version = VERSIONS[1])
      url = "https://api.steampowered.com/#{interface}/#{method}/#{api_version}/"
      connection.request(:get, url, options.merge(key: config.api_key))
    end
  end
end
