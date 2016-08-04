module Vertigo
  module Rtm
    class AppearanceChannel < Vertigo::Rtm::ApplicationCable::Channel
      def subscribed
        stream_from 'vertigo:rtm:appearance'
        current_user.online!
      end

      def unsubscribed
        current_user.offline!
      end
    end
  end
end
