RSpec::Matchers.define :serialize_object do |expected|
  match do |response|
    serialize_object = @serializer_klass.new(expected, scope: controller)
    ActiveModelSerializers::Adapter::JsonApi.new(serialize_object, key_transform: :camel_lower).to_json == response.body
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end
