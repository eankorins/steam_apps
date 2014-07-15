json.array!(@players) do |player|
  json.extract! player, :id, :name, :id
  json.url player_url(player, format: :json)
end
