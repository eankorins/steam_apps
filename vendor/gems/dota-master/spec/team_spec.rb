require 'spec_helper'
require 'steam/team'

describe Steam::Team do
  let(:team) { Steam::Team.new(fixture(:team)) }

  it 'returns id' do
    team.id.must_equal 39
  end

  it 'returns name' do
    team.name.must_equal 'Evil Geniuses'
  end

  it 'returns logo' do
    team.logo.must_equal 1155424861288756748
  end

  it 'returns complete status' do
    team.complete?.must_equal true
  end
end
