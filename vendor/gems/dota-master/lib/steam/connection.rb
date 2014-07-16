require 'faraday'
require 'faraday_middleware'

module Steam
  class Connection
    def initialize
      @faraday = Faraday.new do |faraday|
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
    end

    def request(method, url, options = {})
      puts url 
      puts options
      
      response = @faraday.public_send(method) do |request|
        request.url(url, options)
      end

      response.body
    end
  end
end
