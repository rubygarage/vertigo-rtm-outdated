module Vertigo
  module Rtm
    class PreferencesController < Vertigo::Rtm::ApplicationController
      before_action :set_and_authorize_preference

      def show
        render_resource @preference
      end

      def update
        @preference.update!(preference_params)
        render_resource @preference
      end

      private

      def set_and_authorize_preference
        @preference =
          if params[:conversation_id]
            vertigo_rtm_current_user.vertigo_rtm_conversation_preference(params[:conversation_id])
          else
            vertigo_rtm_current_user.vertigo_rtm_preference
          end

        authorize @preference
      end

      def preference_params
        params.require(:preference).permit(
          :notify_on_message,
          :notify_on_mention,
          :highlight_words,
          :muted
        )
      end
    end
  end
end
