module Vertigo
  module Rtm
    class ApplicationSerializer < ::ActiveModel::Serializer
      attribute :created_at do
        object.created_at.iso8601
      end

      attribute :updated_at do
        object.updated_at.iso8601
      end
    end
  end
end
