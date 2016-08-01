module Vertigo
  module Rtm
    class PreferencesController < ApplicationController
      def show
      end

      def update
      end

      private

      def preference_params
        params.require(:user).permit(
          :highlight_words,
          :push_everything,
          :muted
        )
      end
    end
  end
end
