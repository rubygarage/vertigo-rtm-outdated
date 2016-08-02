module Vertigo
  module Rtm
    class PreferencesController < ApplicationController
      before_action :set_and_preference_channel

      def show
        render_resource @preference
      end

      def update
        @preference.update!(preference_params)
        render_resource @preference
      end

      private

      def set_and_preference_channel
        @preference =
          if params[:conversation_id]
            vertigo_rtm_current_user
              .conversation_user_relations
              .find_by!(conversation_id: params[:conversation_id])
              .preference
          else
            vertigo_rtm_current_user.preference
          end

        authorize @preference
      end

      def preference_params
        params.require(:user).permit(
          :notify_on_message,
          :notify_on_mention,
          :highlight_words,
          :muted
        )
      end
    end
  end
end
