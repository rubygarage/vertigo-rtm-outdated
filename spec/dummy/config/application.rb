require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'vertigo/rtm'

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Rails.application.config.active_job.queue_adapter = :inline
    Rails.application.routes.default_url_options = { host: 'localhost:3000' }
  end
end
