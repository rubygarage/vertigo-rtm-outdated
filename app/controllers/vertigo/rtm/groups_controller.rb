module Vertigo
  module Rtm
    class GroupsController < Vertigo::Rtm::ApplicationController
      before_action :set_and_authorize_group, only: [:show]

      def create
        authorize Group
        group = Group.create!(group_params)
        render_resource group, status: :created
      end

      def show
        render_resource @group
      end

      private

      def set_and_authorize_group
        @group = Group.find(params[:id])
        authorize @group
      end

      def group_params
        params
          .require(:group)
          .permit(member_ids: [])
          .merge(creator_id: vertigo_rtm_current_user.id)
      end
    end
  end
end
