module Vertigo
  module Rtm
    class ConversationPolicy < Vertigo::Rtm::ApplicationPolicy
      def index_message?
        member_or_creator?
      end

      def create_message?
        member_or_creator?
      end

      def create?
        true
      end

      def show?
        member_or_creator?
      end

      def update?
        creator?
      end

      private

      def creator?
        record.creator_id == user.id
      end

      def member_or_creator?
        creator? || record.members.exists?(user.id)
      end
    end
  end
end
