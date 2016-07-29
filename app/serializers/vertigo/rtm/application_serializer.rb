module Vertigo
  module Rtm
    class ApplicationSerializer < ::ActiveModel::Serializer
      attributes :id

      def initialize(model, options)
        super
        self.class._type = object.model_name.route_key
      end
    end
  end
end
