module Vertigo
  module Rtm
    class EventJob < Vertigo::Rtm::ApplicationJob
      def perform(event_name, resource_id)
        event_source = Vertigo::Rtm::Notification::EventSource.for(event_name, resource_id)
        Vertigo::Rtm::Notification::Broadcast.new(event_source).call
      end
    end
  end
end
