module Vertigo
  module Rtm
    module ApplicationCable
      class Channel < ::ApplicationCable::Channel
        protected

        def vertigo_rtm_current_user
          send(Vertigo::Rtm.current_user_method)
        end

        def broadcasting(*args)
          [channel_prefix, channel_root, *args].join(':')
        end

        def channel_prefix
          'vertigo:rtm'
        end

        def channel_root
          self.class
              .name
              .demodulize
              .underscore
              .gsub(/_channel$/, '')
        end
      end
    end
  end
end
