require 'steam/utils/inspectable'

module Steam
  class App
    include Utils::Inspectable
    attr_reader :raw_app

    # Initializes a new App object
    #
    # @param raw_friend [Hash]
    def initialize(raw_app)
      @raw_app = raw_app
    end

    # The app ID
    #
    # @return [Integer]
    def id
      raw_app['appid'].to_s
    end

    # The app name
    #
    # @return [String]
    def name
      raw_app['name']
    end
  end
end
