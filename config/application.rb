require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BankDemo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.time_zone = "Hanoi"
    config.active_record.default_timezone = :local
    
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :en

    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true 
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:                  ENV['SMTP_ADDRESS'],
      port:                     ENV['SMTP_PORT'].to_i,
      domain:                   ENV['SMTP_DOMAIN'],
      authentication:           ENV['SMTP_AUTH'],
      user_name:                ENV['SMTP_USERNAME'],
      password:                 ENV['SMTP_PASSWORD'],
      enable_starttls_auto:     ENV['SMTP_ENABLE_STARTTLS_AUTO'] == 'true'
    }



    config.action_mailer.default_url_options = {
      host: ENV['ACTION_MAILER_HOST']
    }
    config.action_mailer.default_options = {
      from: ENV['ACTION_MAILER_DEFAULT_FROM']
    }
  end
end
