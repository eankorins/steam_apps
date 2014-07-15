json.array!(@games) do |game|
  json.extract! game, :id, :name, :cost, :played
  json.url game_url(game, format: :json)
end
