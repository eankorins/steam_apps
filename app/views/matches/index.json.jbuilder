json.array!(@matches) do |match|
  json.extract! match, :id, :match_id, :match_seq_num, :start_time, :lobby_type
  json.url match_url(match, format: :json)
end
