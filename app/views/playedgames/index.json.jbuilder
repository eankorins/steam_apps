json.array!(@playedgames) do |playedgame|
  json.extract! playedgame, :id, :player_id, :game_id, :playedtime
  json.url playedgame_url(playedgame, format: :json)
end
