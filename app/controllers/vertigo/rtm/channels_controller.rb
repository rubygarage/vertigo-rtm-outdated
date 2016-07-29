require_dependency 'vertigo/rtm/application_controller'

module Vertigo
  module Rtm
    class ChannelsController < ApplicationController
      before_action :set_channel, only: [:show, :update, :destroy]
      before_action :set_conversation_current_user_relation, only: [:leave]
      before_action :set_conversation_user_relation, only: [:kick]

      def create
        channel = Channel.create!(channel_params)
        render_resource channel
      end

      def show
        render_resource @channel
      end

      def update
        @channel.update!(channel_params)
        render_resource @channel
      end

      def destroy
        @channel.destroy!
        render_resource @channel
      end

      def leave
        @channel_user_connection.destroy!
        render_resource channel
      end

      def kick
        @channel_user_connection.destroy!
        render_resource channel
      end

      def invite
        ConversationUserRelation.create(
          conversation_id: params[:id], user_id: params[:user_id]
        ).create!
        render_resource channel
      end

      private

      def set_channel
        @channel = Channel.find(params[:id])
      end

      def set_conversation_user_relation
        @channel_user_connection = ConversationUserRelation.create(
          conversation_id: params[:id], user_id: params[:user_id]
        )
      end

      def set_conversation_current_user_relation
        @channel_user_connection = ConversationUserRelation.create(
          conversation_id: params[:id], user_id: params[:user_id]
        )
      end

      def channel_params
        params.require(:channel).permit(:name, member_ids: [])
      end
    end
  end
end
