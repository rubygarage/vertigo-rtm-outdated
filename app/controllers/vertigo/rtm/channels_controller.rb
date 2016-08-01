module Vertigo
  module Rtm
    class ChannelsController < ApplicationController
      before_action :set_channel, only: [:show, :update, :destroy, :leave, :kick, :invite]

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

      def destroy
        @channel.destroy!
        head :no_content
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
        @channel.conversation_user_relations.create!(user_id: params[:member_id])
        render_resource @channel
      end

      private

      def set_channel
        @channel = Channel.find(params[:id])
        authorize @channel
      end

      def channel_user_relation(user_id)
        @channel.conversation_user_relations.find_by!(user_id: user_id)
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
