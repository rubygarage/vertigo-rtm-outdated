module Vertigo
  module Rtm
    class UsersController < Vertigo::Rtm::ApplicationController
      def index
        @users = policy_scope(Vertigo::Rtm.user_class)
        render json: @users,
               each_serializer: Vertigo::Rtm::UserSerializer,
               root: :data
      end

      def update
        authorize vertigo_rtm_current_user

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
