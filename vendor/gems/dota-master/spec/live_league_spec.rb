require 'spec_helper'

describe Steam::LiveLeague do
  let(:live_league) { Steam::LiveLeague.new(fixture(:live_league)) }

  it 'returns league id' do
    live_league.id.must_equal 21
  end

  it 'returns a number of spectators' do
    live_league.spectators.must_equal 2485
  end

  it 'returns lobby id' do
    live_league.lobby_id.must_equal 22813809906189926
  end

  it 'returns tower state' do
    live_league.tower_state.must_equal 4040484
  end

  it 'returns players' do
    live_league.players.must_be_kind_of Array
    live_league.players.first.must_be_kind_of Steam::LiveLeague::Player
  end

  it 'returns dire team' do
    live_league.dire.must_be_kind_of Steam::Team
  end

  it 'returns radiant team' do
    live_league.radiant.must_be_kind_of Steam::Team
  end

  it 'returns string representation of the object' do
    object_id = (live_league.object_id << 1).to_s(16)
    live_league.inspect.must_equal "#<Steam::LiveLeague:0x#{object_id}>"
  end
end
