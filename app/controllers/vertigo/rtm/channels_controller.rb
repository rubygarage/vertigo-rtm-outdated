module Vertigo
  module Rtm
    class ChannelsController < ApplicationController
      before_action :set_and_authorize_channel, only: [:show, :update, :archive, :unarchive, :leave, :kick, :invite]

      def create
        authorize Channel
        channel = Channel.create!(create_channel_params)
        render_resource channel, status: :created
      end

      def show
        render_resource @channel
      end

      def update
        @channel.update!(update_channel_params)
        render_resource @channel
      end

      def archive
        @channel.archived!
        head :ok
      end

      def unarchive
        @channel.unarchived!
        head :ok
      end

      def leave
        channel_user_relation(vertigo_rtm_current_user.id).destroy!
        head :ok
      end

      def kick
        channel_user_relation(params[:member_id]).destroy!
        head :ok
      end

      def invite
        @channel.memberships.create!(user_id: params[:member_id])
        render_resource @channel
      end

      private

      def set_and_authorize_channel
        @channel = Channel.find(params[:id])
        authorize @channel
      end

      def channel_user_relation(user_id)
        @channel.memberships.find_by!(user_id: user_id)
      end

      def create_channel_params
        params.require(:channel)
              .permit(:name, member_ids: [])
              .merge(creator: vertigo_rtm_current_user)
      end

      def update_channel_params
        params.require(:channel).permit(:name)
      end
    end
  end
end
