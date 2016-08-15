module Vertigo
  module Rtm
    module Notify
      module Conversation
        class Base < Vertigo::Rtm::Notify::Base
          protected

          def target_users
            resource.members
                    .vertigo_rtm_not_offline
                    .where.not(id: resource.creator_id)
          end
        end
      end
    end
  end
end
