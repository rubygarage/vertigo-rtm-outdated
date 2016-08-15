module Vertigo
  module Rtm
    module Notify
      module Message
        class Base < Vertigo::Rtm::Notify::Base
          protected

          def target_users
            resource.conversation
                    .members
                    .vertigo_rtm_not_offline
                    .where(id: resource.creator_id)
          end
        end
      end
    end
  end
end
