Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :test
  config.action_mailer.delivery_method = :smtp

  # config.action_mailer.default_url_options = { :host => 'https://localhost:3000' }
  # config.action_mailer.smtp_settings = {
  #   :user_name => ENV['SENDGRID_USERNAME'],
  #   :password => ENV['SENDGRID_PASSWORD'],
  #   :domain => 'gmail.com',
  #   :address => 'smtp.sendgrid.net',
  #   :port => 587,
  #   :authentication => :plain,
  #   :enable_starttls_auto => true
  # }

  #let paperclip know where to look for imagemagick... get the filepath by querying "which convert" after installing imagemagick
  #to run on Mac
  #Paperclip.options[:command_path] = "/usr/local/bin/"
   #to run on Ubuntu
  # Paperclip.options[:command_path] = "/usr/bin/convert" 

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # For Cap
  # Need to comment out to run in local

  # Disable Rails's static asset server (Apache or nginx will already do this)

  config.serve_static_files = true

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # # #Compress JavaScripts and CSS
  config.assets.compress = true

  # # # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # # # Generate digests for assets URLs
  config.assets.digest = true

end
