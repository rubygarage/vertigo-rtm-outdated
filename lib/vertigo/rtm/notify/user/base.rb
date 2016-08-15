module Vertigo
  module Rtm
    module Notify
      module User
        class Base < Vertigo::Rtm::Notify::Base
          protected

          def target_users
            Vertigo::Rtm.user_class
                        .vertigo_rtm_not_offline
                        .where.not(id: resource.id)
          end

          def server_broadcast(user)
            event = build_event(user)
            ActionCable.server.broadcast("vertigo:rtm:event:#{user.id}", event)
          end

          def build_event(user)
            options = {
              scope: Vertigo::Rtm::ViewContext.new(user),
              serializer: Vertigo::Rtm::UserSerializer
            }

            Event.new("#{event_prefix}.#{event_root}", resource, options)
          end
        end
      end
    end
  end
end
