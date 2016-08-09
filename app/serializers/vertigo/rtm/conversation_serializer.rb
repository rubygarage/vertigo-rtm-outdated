module Vertigo
  module Rtm
    class ConversationSerializer < Vertigo::Rtm::ApplicationSerializer
      type 'conversations'

      attributes :name, :state, :members_count, :messages_count

      attribute :member_ids do
        object.member_ids.map(&:to_s)
      end

      attribute :creator_id do
        object.creator_id.to_s
      end

      attribute :last_read_at do
        conversation_user_relation.last_read_at
      end

      attribute :unread_count do
        object.messages.unread_by(scope.vertigo_rtm_current_user.id).count
      end

      link :self do
        scope.conversation_url(object.id)
      end

      private

      def conversation_user_relation
        object.memberships.find_by(user_id: scope.vertigo_rtm_current_user.id)
      end
    end
  end
end
