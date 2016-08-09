module Vertigo
  module Rtm
    class ChannelPolicy < Vertigo::Rtm::ConversationPolicy
      def leave?
        member_or_creator?
      end

      def kick?
        creator?
      end

      def invite?
        member_or_creator?
      end

      def archive?
        creator?
      end

      def unarchive?
        creator?
      end
    end
  end
end
