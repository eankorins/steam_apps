Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  ENV["REDISTOGO_URL"] = 'redis://redistogo:11753612c96ed6a7442c8e4aa2e8c232@angelfish.redistogo.com:9159'
  # Do not eager load code on boot.
  config.eager_load = true
  config.assets.precompile = ['*.js', '*.scss']
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true
  Steam.configure do |config|
    config.api_key = 'A8229F479840DA66362A59443FF717CF'
  end
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
