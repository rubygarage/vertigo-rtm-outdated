module Vertigo
  module Rtm
    class ChannelSerializer < ApplicationSerializer
      attributes :name, :state, :creator_id, :created_at,
        :updated_at, :members_count, :messages_count

      attribute :last_read_at do
        conversation_user_relation.last_read_at
      end

      attribute :member_ids do
        object.conversation_user_relations.pluck(:user_id)
      end

      attribute :unread_count do
        object.messages.unread_for(scope.vertigo_rtm_current_user.id).count
      end

      link :self do
        scope.channel_url(object.id)
      end

      private

      def conversation_user_relation
        ConversationUserRelation.find_by(
          user_id: scope.vertigo_rtm_current_user.id, conversation_id: object.id
        )
      end
    end
  end
end
