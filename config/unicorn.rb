worker_processes Integer(ENV["WEB_CONCURRENCY"] || 5)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDISTOGO_URL"], namespace: 'sidekiq' }
  end

  unless Rails.env.production?
    Sidekiq.configure_client do |config|
      config.redis = { url: ENV["REDISTOGO_URL"], namespace: 'sidekiq'  }
    end
  end
  Sidekiq.configure_client do |config|
    config.redis = { size: 1, namespace: 'sidekiq' }

  end
  ENV["REDISTOGO_URL"] = 'redis://redistogo:11753612c96ed6a7442c8e4aa2e8c232@angelfish.redistogo.com:9159/'


end