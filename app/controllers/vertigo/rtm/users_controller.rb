require_dependency 'vertigo/rtm/application_controller'

module Vertigo
  module Rtm
    class UsersController < ApplicationController
      load_and_authorize_resource :user, class: Vertigo::Rtm.user_class

      def index
        render json: @users,
               each_serializer: Vertigo::Rtm::UserSerializer,
               root: :data
      end

      def update
        vertigo_rtm_current_user.update_attributes(user_params)

        render json: vertigo_rtm_current_user,
               serializer: Vertigo::Rtm::UserSerializer,
               root: :data
      end

      private

      def user_params
        params.require(:user).permit(:status)
      end
    end
  end
end
