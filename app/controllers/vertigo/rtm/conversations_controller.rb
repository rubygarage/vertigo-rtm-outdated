module Vertigo
  module Rtm
    class ConversationsController < Vertigo::Rtm::ApplicationController
      def index
        render_resource policy_scope(Conversation.all)
      end
    end
  end
end
