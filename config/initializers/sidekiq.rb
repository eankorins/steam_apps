ENV["REDISTOGO_URL"] = 'redis://redistogo:11753612c96ed6a7442c8e4aa2e8c232@angelfish.redistogo.com:9159/'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDISTOGO_URL"], namespace: 'sidekiq' }
end

unless Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDISTOGO_URL"], namespace: 'sidekiq'  }
  end
end