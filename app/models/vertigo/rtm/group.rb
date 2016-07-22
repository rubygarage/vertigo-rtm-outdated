module Vertigo
  module Rtm
    class Group < Vertigo::Rtm::Conversation
      def group?
        true
      end
    end
  end
end
