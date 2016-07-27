module Vertigo
  module Rtm
    class ApplicationController < ::ApplicationController
      layout :vertigo_rtm_layout

      include Pundit

      helper_method :vertigo_rtm_current_user

      protected

      def vertigo_rtm_current_user
        send(Vertigo::Rtm.current_user_method) || NullUser.new
      end

      private

      def vertigo_rtm_layout
        Vertigo::Rtm.layout
      end

      def pundit_user
        vertigo_rtm_current_user
      end
    end
  end
end
