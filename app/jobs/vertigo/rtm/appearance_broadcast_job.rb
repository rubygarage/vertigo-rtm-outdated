module Vertigo
  module Rtm
    class AppearanceBroadcastJob < Vertigo::Rtm::ApplicationJob
      queue_as :default

      def perform(user)
        ActionCable.server.broadcast(
          'vertigo:rtm:appearance',
          render_resource(user, serializer: Vertigo::Rtm::UserSerializer)
        )
      end
    end
  end
end
