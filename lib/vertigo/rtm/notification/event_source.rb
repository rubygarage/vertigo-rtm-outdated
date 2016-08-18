module Vertigo
  module Rtm
    module Notification
      module EventSource
        def self.for(event_name, resource_id)
          resource, = event_name.split('.')

          case resource
          when 'channel', 'group'
            Vertigo::Rtm::Notification::EventSource::Conversation.new(event_name, resource_id)
          when 'message'
            Vertigo::Rtm::Notification::EventSource::Message.new(event_name, resource_id)
          when 'user'
            Vertigo::Rtm::Notification::EventSource::User.new(event_name, resource_id)
          end
        end
      end
    end
  end
end
