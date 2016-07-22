module Vertigo
  module Rtm
    class ApplicationController < ::ApplicationController
      layout :vertigo_rtm_layout

      helper_method :vertigo_rtm_current_user

      protected

      def vertigo_rtm_current_user
        send(Vertigo::Rtm.current_user_method)
      end

      private

      def vertigo_rtm_layout
        Vertigo::Rtm.layout
      end
    end
  end
end
