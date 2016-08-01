module Vertigo
  module Rtm
    class MessagesController < ApplicationController
      def index
      end

      def create
      end

      def update
      end

      def destroy
      end

      private

      def message_params
        params.require(:message).permit(:text)
      end
    end
  end
end
