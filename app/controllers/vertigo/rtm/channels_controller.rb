require_dependency 'vertigo/rtm/application_controller'

module Vertigo
  module Rtm
    class ChannelsController < ApplicationController
      def create
      end

      def show
      end

      def update
      end

      def destroy
      end

      def leave
      end

      def kick
      end

      def invite
      end

      private

      def channel_params
        params.require(:channel).permit(:name, member_ids: [])
      end
    end
  end
end
