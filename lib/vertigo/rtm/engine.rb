module Vertigo
  module Rtm
    class Engine < ::Rails::Engine
      isolate_namespace Vertigo::Rtm

      config.generators do |g|
        g.test_framework      :rspec,        fixture: false
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        g.assets false
        g.helper false
      end

      config.to_prepare do
        if Vertigo::Rtm.user_class
          Vertigo::Rtm.user_class.send(:include, Vertigo::Rtm::UserExtender)
        end
      end
    end
  end
end
