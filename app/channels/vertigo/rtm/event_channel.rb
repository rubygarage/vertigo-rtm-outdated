module Vertigo
  module Rtm
    class EventChannel < Vertigo::Rtm::ApplicationCable::Channel
      def subscribed
        stream_from broadcasting(vertigo_rtm_current_user.id)
      end

      def unsubscribed
        vertigo_rtm_current_user.offline!
      end
    end
  end
end
