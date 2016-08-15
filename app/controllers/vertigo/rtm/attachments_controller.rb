module Vertigo
  module Rtm
    class AttachmentsController < ApplicationController
      before_action :set_and_authorize_conversation
      before_action :set_and_authorize_attachment, only: :show

      def index
        @attachments = policy_scope(@conversation.attachments)
        @attachments = @attachments.paginate(page: params[:page])
        render_resource @attachments
      end

      def show
        render_resource @attachment
      end

      private

      def set_and_authorize_conversation
        @conversation = Conversation.find(params[:conversation_id])
        authorize @conversation, :show?
      end

      def set_and_authorize_attachment
        @attachment = @conversation.attachments.find_by!(params[:id])
        authorize @attachment
      end
    end
  end
end
