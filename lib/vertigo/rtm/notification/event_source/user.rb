module Vertigo
  module Rtm
    module Notification
      module EventSource
        class User < Vertigo::Rtm::Notification::EventSource::Base
          def payload
            @payload ||= Vertigo::Rtm.user_class.find(resource_id)
          end

          def target_users
            Vertigo::Rtm.user_class
                        .vertigo_rtm_not_offline
                        .where.not(id: payload.id)
          end

          def as_json(recipient, options = {})
            default_options = {
              scope: Vertigo::Rtm::ViewContext.new(recipient),
              serializer: Vertigo::Rtm::UserSerializer
            }.merge(options)

            Vertigo::Rtm::Notification::EventSource::Serializer.new(self, default_options).attributes
          end
        end
      end
    end
  end
end
