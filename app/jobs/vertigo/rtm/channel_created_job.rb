module Vertigo
  module Rtm
    class ChannelCreatedJob < Vertigo::Rtm::ApplicationJob
      queue_as :default

      # rubocop:disable Metrics/MethodLength
      def perform(membership)
        scope = ViewContext.new(membership.user)

        ActionCable.server.broadcast(
          'vertigo:rtm:event',
          type: 'channel_created',
          resource: JSON.parse(
            render_resource(
              membership.conversation,
              serializer: Vertigo::Rtm::ChannelSerializer,
              scope: scope
            )
          )
        )
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
