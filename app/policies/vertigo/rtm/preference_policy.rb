module Vertigo
  module Rtm
    class PreferencePolicy < Vertigo::Rtm::ApplicationPolicy
      def show?
        can_moderate?
      end

      def update?
        can_moderate?
      end

      private

      def can_moderate?
        if record.userable?
          can_moderate_userable?
        else
          can_moderate_membershipable?
        end
      end

      def can_moderate_userable?
        record.preferenceable_id == user.id
      end

      def can_moderate_membershipable?
        record.preferenceable.user_id == user.id && conversation_policy.show?
      end

      def conversation_policy
        @conversation_policy ||= ConversationPolicy.new(user, record.preferenceable.conversation)
      end
    end
  end
end
