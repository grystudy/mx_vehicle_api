require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MxVehicleApi
  class Application < Rails::Application
    config.time_zone = 'Beijing'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    # config.paths.add File.join('app', 'api'), glob:'*.rb'
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    #config.autoload_paths += Dir[Rails.root.join('app', 'api', 'entities','*')]
  end
end
