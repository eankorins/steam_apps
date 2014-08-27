json.array!(@participants) do |participant|
  json.extract! participant, :id, :account_id, :player_slot, :hero_id, :match_id
  json.url participant_url(participant, format: :json)
end
