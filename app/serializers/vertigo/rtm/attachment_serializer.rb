module Vertigo
  module Rtm
    class AttachmentSerializer < ApplicationSerializer
      type 'attachments'

      attributes :attachment

      attribute :message_id do
        object.message_id.to_s
      end

      link :self do
        scope.conversation_attachments_url(object.message.conversation_id, object)
      end
    end
  end
end
