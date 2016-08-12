RSpec::Matchers.define :serialize_collection do |expected|
  match do |response|
    options = {
      key_transform: :camel_lower,
      adapter: ActiveModelSerializers::Adapter::JsonApi,
      each_serializer: @serializer_klass,
      serialization_context: controller,
      scope: controller
    }

    ActiveModelSerializers::SerializableResource.new(expected, options).to_json == response.body
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end
