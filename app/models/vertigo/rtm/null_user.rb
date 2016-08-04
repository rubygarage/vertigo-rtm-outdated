module Vertigo
  module Rtm
    class NullUser
      def id
        0
      end

      def name
        'Anonymous User'
      end

      def policy_class
        Vertigo::Rtm::UserPolicy
      end

      def vertigo_rtm_conversations
        Conversation.none
      end

      def vertigo_rtm_preference
        Vertigo::Rtm::Preference.new
      end
    end
  end
end
