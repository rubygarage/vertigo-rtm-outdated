module Vertigo
  module Rtm
    module Notification
      module EventSource
        class Base
          attr_reader :event_name, :resource_id

          def initialize(event_name, resource_id)
            @event_name = event_name
            @resource_id = resource_id
          end

          def payload
            raise(NotImplementedError)
          end

          def target_users
            raise(NotImplementedError)
          end

          def as_json(recipient, options = {})
            default_options = {
              scope: Vertigo::Rtm::ViewContext.new(recipient)
            }.merge(options)

            Vertigo::Rtm::Notification::EventSource::Serializer.new(self, default_options).attributes
          end
        end
      end
    end
  end
end
