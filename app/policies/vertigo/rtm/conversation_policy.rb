module Vertigo
  module Rtm
    class ConversationPolicy < ApplicationPolicy
      def index_message?
        member_or_creator?
      end

      def create_message?
        member_or_creator?
      end

      private

      def member_or_creator?
        record.creator_id == user.id || user.vertigo_rtm_conversations.exists?(record.id)
      end
    end
  end
end
