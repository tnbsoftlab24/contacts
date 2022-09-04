require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Naturetropicale
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    #Add il8n to generate local language
    config.i18n.default_locale = :en

    #Add function to show errors page
    config.exceptions_app = self.routes 

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.autoloader = :classic
    # config.time_zone = "Eastern Time (US & Canada)"
    config.assets.precompile += %w{foundation_emails.css}
    config.assets.initialize_on_precompile = false
  end
end
