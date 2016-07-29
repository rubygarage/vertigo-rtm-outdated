module Vertigo
  module Rtm
    class ApplicationController < ::ApplicationController
      layout :vertigo_rtm_layout
      serialization_scope :view_context

      rescue_from StandardError, with: :internal_server_error
      rescue_from Pundit::NotAuthorizedError, with: :access_denied
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      include Pundit

      helper_method :vertigo_rtm_current_user

      protected

      def vertigo_rtm_current_user
        send(Vertigo::Rtm.current_user_method) || NullUser.new
      end

      private

      def render_resource(resource, options = {})
        render_options = {
          json: resource,
          adapter: ActiveModel::Serializer::Adapter::JsonApi,
          key_transform: :camel_lower
        }.merge(options)

        render render_options
      end

      def internal_server_error(ex)
        render json: Exceptions::InternalServerErrorSerializer.new(ex).as_json,
          status: :internal_server_error
      end

      def access_denied(ex)
        render json: Exceptions::AccessDenied.new(ex).as_json,
          status: :forbidden
      end

      def not_found(ex)
        render json: Exceptions::NotFoundSerializer.new(ex).as_json,
          status: :not_found
      end

      def unprocessable_entity(ex)
        render json: Exceptions::UnprocessableEntitySerializer.new(ex).as_json,
          status: :unprocessable_entity
      end

      def vertigo_rtm_layout
        Vertigo::Rtm.layout
      end

      def pundit_user
        vertigo_rtm_current_user
      end
    end
  end
end
