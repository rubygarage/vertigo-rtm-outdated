module Vertigo
  module Rtm
    class UsersController < Vertigo::Rtm::ApplicationController
      def index
        @users = policy_scope(Vertigo::Rtm.user_class)

        @users = Vertigo::Rtm::UserQuery.new(@users, params).results

        render_resource @users, each_serializer: Vertigo::Rtm::UserSerializer
      end

      def update
        authorize vertigo_rtm_current_user

        vertigo_rtm_current_user.update!(user_params)

        render_resource vertigo_rtm_current_user, serializer: Vertigo::Rtm::UserSerializer
      end

      private

      def user_params
        params.require(:user).permit(:vertigo_rtm_status)
      end
    end
  end
end
