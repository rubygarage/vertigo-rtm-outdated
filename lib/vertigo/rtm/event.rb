module Vertigo
  module Rtm
    class Event
      attr_reader :name, :resource

      def initialize(name, resource, options = {})
        @name = name
        @resource = serialize_resource(resource, options)
      end

      private

      def serialize_resource(resource, options = {})
        default_options = {
          adapter: ActiveModelSerializers::Adapter::JsonApi,
          key_transform: :camel_lower
        }.merge(options)

        ActiveModelSerializers::SerializableResource.new(resource, default_options).as_json
      end
    end
  end
end
