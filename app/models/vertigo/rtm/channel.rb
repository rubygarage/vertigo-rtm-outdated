module Vertigo
  module Rtm
    class Channel < Vertigo::Rtm::Conversation
      def channel?
        true
      end
    end
  end
end
