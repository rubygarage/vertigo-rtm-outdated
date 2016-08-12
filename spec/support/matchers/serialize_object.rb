RSpec::Matchers.define :serialize_object do |expected|
  match do |response|
    options = {
      key_transform: :camel_lower,
      adapter: ActiveModelSerializers::Adapter::JsonApi,
      serializer: @serializer_klass,
      scope: controller
    }

    ActiveModelSerializers::SerializableResource.new(expected, options).to_json == response.body
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end
