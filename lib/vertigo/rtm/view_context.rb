module Vertigo
  module Rtm
    class ViewContext
      include Vertigo::Rtm::Engine.routes.url_helpers

      attr_reader :vertigo_rtm_current_user

      def initialize(vertigo_rtm_current_user)
        @vertigo_rtm_current_user = vertigo_rtm_current_user
      end

      def default_url_options
        Rails.application.routes.default_url_options
      end
    end
  end
end
