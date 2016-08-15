module Vertigo
  module Rtm
    class AppearanceChannel < Vertigo::Rtm::ApplicationCable::Channel
      def subscribed
        stream_from broadcasting
        vertigo_rtm_current_user.online!
      end

      def unsubscribed
        vertigo_rtm_current_user.offline!
      end
    end
  end
end
