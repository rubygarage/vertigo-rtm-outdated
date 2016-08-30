module Vertigo
  module Rtm
    class ConversationsController < Vertigo::Rtm::ApplicationController
      def index
        @conversation_presenter = Vertigo::Rtm::ConversationPresenter.new(vertigo_rtm_current_user)
        render_resource @conversation_presenter, include: [:current_user, :channels, :groups]
      end
    end
  end
end
