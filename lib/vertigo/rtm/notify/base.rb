module Vertigo
  module Rtm
    module Notify
      class Base
        def initialize(resource)
          @resource = resource
        end

        def call
          target_users.each do |target_user|
            server_broadcast(target_user)
          end
        end

        protected

        attr_reader :resource

        def target_users
          raise(NotImplementedError)
        end

        def event_prefix
          self.class
              .parent
              .name
              .demodulize
              .underscore
        end

        def event_root
          self.class
              .name
              .demodulize
              .underscore
        end

        def server_broadcast(user)
          view_context = Vertigo::Rtm::ViewContext.new(user)
          event = Vertigo::Rtm::Event.new("#{event_prefix}.#{event_root}", resource, scope: view_context)
          ActionCable.server.broadcast("vertigo:rtm:event:#{user.id}", event)
        end
      end
    end
  end
end
