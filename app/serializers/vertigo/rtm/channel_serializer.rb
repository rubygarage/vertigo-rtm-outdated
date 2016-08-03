module Vertigo
  module Rtm
    class ChannelSerializer < ApplicationSerializer
      type 'channels'

      attributes :name, :state, :creator_id, :created_at, :updated_at,
                 :members_count, :member_ids, :messages_count

      attribute :last_read_at do
        conversation_user_relation.last_read_at
      end

      attribute :unread_count do
        object.messages.unread_by(scope.vertigo_rtm_current_user.id).count
      end

      link :self do
        scope.channel_url(object.id)
      end

      private

      def conversation_user_relation
        object.memberships.find_by(user_id: scope.vertigo_rtm_current_user.id)
      end
    end
  end
end
