Tradesite::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  config.assets.compile = true
  config.assets.debug = true
  config.action_mailer.default_url_options = {:host => 'localhost:3000'}
  ENV['PANDASTREAM_URL'] = "https://7f13582e2f115bee5713:ae5168330e865d88b2f4@api.pandastream.com/f3bd53ae846f7741fc32f0924d7ccce4"
    config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
    :bucket => 'myfxprofitsAssets',
    :access_key_id => 'AKIAJJF2NOP3YBOAJ7HQ',
    :secret_access_key => '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'
    }
  }

end
