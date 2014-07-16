require 'spec_helper'

describe 'delegation' do
  let(:mock) { MiniTest::Mock.new }

  it 'delegates #match to the client' do
    mock.expect(:match, :result, [123])

    Steam.stub(:client, mock) do
      Steam.match(123).must_equal :result
    end

    mock.verify
  end

  it 'delegates #leagues to the client' do
    mock.expect(:leagues, :result, [])

    Steam.stub(:client, mock) do
      Steam.leagues.must_equal :result
    end

    mock.verify
  end

  it 'delegates #live_leagues to the client' do
    mock.expect(:live_leagues, :result, [])

    Steam.stub(:client, mock) do
      Steam.live_leagues.must_equal :result
    end

    mock.verify
  end

  it 'delegates #history to the client' do
    mock.expect(:history, :result, [{account_id: 123456789}])

    Steam.stub(:client, mock) do
      Steam.history(account_id: 123456789).must_equal :result
    end

    mock.verify
  end
end
