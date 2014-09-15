require 'steam/version'
require 'steam/client'

module Steam
  extend SingleForwardable

  def_delegators :client, :game_scheme, :configure, :owned_games, :apps, :match, :history, :history_sequence, :leagues, :live_leagues, :profiles, :profile, :bans, :friends

  def self.client
    @client ||= Client.new
  end
end
