module Vertigo
  module Rtm
    module Notification
      module EventSource
        class Conversation < Vertigo::Rtm::Notification::EventSource::Base
          def payload
            @payload ||= Vertigo::Rtm::Conversation.find(resource_id)
          end

          def target_users
            payload.members
                   .vertigo_rtm_not_offline
                   .where.not(id: payload.creator_id)
          end
        end
      end
    end
  end
end
