module Vertigo
  module Rtm
    class ApplicationController < ::ApplicationController
      layout :vertigo_rtm_layout
      serialization_scope :view_context

      rescue_from StandardError, with: :handle_error

      include Pundit

      helper_method :vertigo_rtm_current_user

      before_action :authenticate_user!

      protected

      def vertigo_rtm_current_user
        send(Vertigo::Rtm.current_user_method)
      end

      private

      def authenticate_user!
        raise Errors::Unauthorized unless vertigo_rtm_current_user.present?
      end

      def render_resource(resource, options = {})
        render_options = {
          json: resource,
          adapter: ActiveModelSerializers::Adapter::JsonApi,
          key_transform: :camel_lower
        }.merge(options)

        render render_options
      end

      def vertigo_rtm_layout
        Vertigo::Rtm.layout
      end

      def pundit_user
        vertigo_rtm_current_user
      end

      def handle_error(ex)
        errors_detector = ErrorsDetector.new(ex)

        render(
          json: ErrorsSerializer.new(*errors_detector.errors).as_json,
          status: errors_detector.status
        ) && return
      end
    end
  end
end
