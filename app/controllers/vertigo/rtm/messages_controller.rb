module Vertigo
  module Rtm
    class MessagesController < Vertigo::Rtm::ApplicationController
      before_action :set_conversation
      before_action :set_and_authorize_message, only: [:update, :destroy]

      def index
        authorize @conversation, :index_message?

        messages = @conversation.messages
        render_resource messages, include: :attachments
      end

      def create
        authorize @conversation, :create_message?

        message = @conversation.messages.create!(message_create_params)
        render_resource message, include: :attachments, status: :created
      end

      def update
        @message.update!(message_update_params)
        render_resource @message, include: :attachments
      end

      def destroy
        @message.destroy!
        head :no_content
      end

      private

      def message_create_params
        params
          .require(:message)
          .permit(:text, attachments_attributes: [:attachment])
          .merge(creator: vertigo_rtm_current_user)
      end

      def message_update_params
        params.require(:message).permit(:text)
      end

      def set_and_authorize_message
        @message = @conversation.messages.find(params[:id])
        authorize @message
      end

      def set_conversation
        @conversation = Conversation.find(params[:conversation_id])
      end
    end
  end
end
