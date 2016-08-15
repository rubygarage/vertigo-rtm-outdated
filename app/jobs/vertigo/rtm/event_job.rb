module Vertigo
  module Rtm
    class EventJob < Vertigo::Rtm::ApplicationJob
      def perform(event, resource)
        # Vertigo::Rtm::Notify.for(event, resource).call
      end
    end
  end
end
