require 'spec_helper'

describe Steam::History do
  before do
    stub_request(:get, 'https://api.steampowered.com/ISteam2Match_570/GetMatchHistory/V001/?key=A8229F479840DA66362A59443FF717CF').
      to_return(status: 200, body: fixture(:history))
  end

  let(:history) { client.history }

  it 'returns the number of results' do
    history.count.must_equal 25
  end

  it 'returns the total number of results for this particular query' do
    history.total_count.must_equal 500
  end

  it 'returns the number of results left for this query' do
    history.remaining_count.must_equal 475
  end

  it 'returns matches' do
    history.matches.must_be_kind_of Array
    history.matches.first.must_be_kind_of Steam::History::Match
  end
end
