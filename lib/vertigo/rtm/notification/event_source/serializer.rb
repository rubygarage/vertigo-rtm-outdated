module Vertigo
  module Rtm
    module Notification
      module EventSource
        class Serializer
          def initialize(event_source, options)
            @event_source = event_source
            @options = options.merge(default_options)
          end

          def attributes
            {
              event: @event_source.event_name,
              payload: serializable_resource
            }
          end

          private

          attr_reader :event_source, :options

          def default_options
            {
              adapter: ActiveModelSerializers::Adapter::JsonApi,
              key_transform: :camel_lower
            }
          end

          def serializable_resource
            ActiveModelSerializers::SerializableResource.new(event_source.payload, options).as_json
          end
        end
      end
    end
  end
end
