json.array!(@heros) do |hero|
  json.extract! hero, :id, :id, :name
  json.url hero_url(hero, format: :json)
end
