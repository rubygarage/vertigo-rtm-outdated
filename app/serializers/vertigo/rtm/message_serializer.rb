module Vertigo
  module Rtm
    class MessageSerializer < ApplicationSerializer
      type 'messages'

      attributes :text, :creator_id, :conversation_id

      has_many :attachments

      link :self do
        scope.conversation_message_url(object.conversation, object)
      end
    end
  end
end
