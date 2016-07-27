require_dependency 'vertigo/rtm/application_controller'

module Vertigo
  module Rtm
    class UsersController < ApplicationController
      def index
      end

      def update
      end

      private

      def user_params
        params.require(:user).permit(:status)
      end
    end
  end
end
