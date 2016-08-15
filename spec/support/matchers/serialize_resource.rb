RSpec::Matchers.define :serialize_resource do |expected|
  match do |response|
    options = {
      key_transform: :camel_lower,
      adapter: ActiveModelSerializers::Adapter::JsonApi
    }.merge(@resource_options)

    ActiveModelSerializers::SerializableResource.new(expected, options).to_json == response.body
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end

  chain :as do |type|
    @resource_options =
      case type
      when :plural
        { each_serializer: @serializer_klass, serialization_context: controller }
      when :singular
        { serializer: @serializer_klass, scope: controller }
      end
  end
end
