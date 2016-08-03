module Vertigo
  module Rtm
    class GroupsController < ApplicationController
      def create
      end

      def show
      end

      def destroy
      end

      private

      def group_params
        params.require(:group).permit(member_ids: [])
      end
    end
  end
end
