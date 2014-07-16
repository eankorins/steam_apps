require 'minitest/autorun'
require 'minitest/spec'
require 'webmock/minitest'
require 'json'

require 'steam'

module SpecHelper
  def client
    @client ||= begin
      client = Steam::Client.new
      client.configure do |config|
        config.api_key = 'TEST_API_KEY'
      end

      client
    end
  end

  def fixture(name)
    JSON.parse(File.read(File.expand_path("../fixtures/#{name}.json", __FILE__)))
  end
end

class MiniTest::Spec
  include SpecHelper
end
