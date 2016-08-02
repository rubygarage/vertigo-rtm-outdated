module Vertigo
  module Rtm
    class MessageSerializer < ApplicationSerializer
      attributes :text,
                 :creator_id,
                 :conversation_id

      attribute :created_at do
        object.created_at.iso8601
      end

      attribute :updated_at do
        object.updated_at.iso8601
      end

      has_many :attachments

      link :self do
        scope.conversation_message_url(object.conversation, object)
      end
    end
  end
end
