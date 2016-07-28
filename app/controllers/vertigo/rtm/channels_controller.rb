require_dependency 'vertigo/rtm/application_controller'

module Vertigo
  module Rtm
    class ChannelsController < ApplicationController
      def create
        channel = Channel.create(channel_params)
        render json: channel
      end

      def show
        channel = Channel.find(params[:id])
        render json: channel
      end

      def update
        channel = Channel.find(params[:id])
        channel.update(channel_params)
        render channel
      end

      def destroy
        channel = Channel.find(params[:id])
        render channel
      end

      def leave
        channel_user_connection = ConversationUserRelation.find_by(
          conversation_id: params[:id], user_id: current_user.id
        )
        render channel
      end

      def kick
        channel_user_connection = ConversationUserRelation.find_by(
          conversation_id: params[:id], user_id: params[:userId]
        )
        render channel
      end

      def invite
        channel_user_connection = ConversationUserRelation.create(
          conversation_id: params[:id], user_id: params[:userId]
        )
        render channel
      end

      private

      def channel_params
        params.require(:channel).permit(:name, member_ids: [])
      end
    end
  end
end
