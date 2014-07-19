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
      option_string = options.map{ |a,b| a.to_s << "=" << b.to_s }.join("&")
      final_url = url << "?" << option_string
      
      Clipboard.copy(final_url)
      puts final_url
      response = @faraday.public_send(method) do |request|
        begin 
          request.url(url, options) 
        rescue => e
          puts e
          sleep(2) 
          request(method, url, options)
        end
      end

      response.body
    end
  end
end
