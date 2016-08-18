module Vertigo
  module Rtm
    module Notification
      module EventSource
        class Message < Vertigo::Rtm::Notification::EventSource::Base
          def payload
            @payload ||= Vertigo::Rtm::Message.find(resource_id)
          end

          def target_users
            Vertigo::Rtm::Conversation.find(payload.conversation_id)
                                      .members
                                      .vertigo_rtm_not_offline
                                      .where(id: payload.creator_id)
          end
        end
      end
    end
  end
end
