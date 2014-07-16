require 'steam/version'
require 'steam/client'

module Steam
  extend SingleForwardable

  def_delegators :client, :configure, :owned_games, :apps, :match, :history, :leagues, :live_leagues, :profiles, :bans, :friends

  def self.client
    @client ||= Client.new
  end
end
