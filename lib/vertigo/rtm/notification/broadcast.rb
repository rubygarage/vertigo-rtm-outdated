module Vertigo
  module Rtm
    module Notification
      class Broadcast
        PREFIX = 'vertigo:rtm:event'.freeze

        def initialize(event_source)
          @event_source = event_source
        end

        def call
          event_source.target_users.each do |target_user|
            forward(target_user)
          end
        end

        private

        attr_reader :event_source

        def forward(target_user)
          attributes = event_source.as_json(target_user)
          ActionCable.server.broadcast("#{PREFIX}:#{target_user.id}", attributes)
        end
      end
    end
  end
end
