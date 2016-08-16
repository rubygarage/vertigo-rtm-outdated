module Vertigo
  module Rtm
    class Channel < Vertigo::Rtm::Conversation
      after_commit :broadcast_channel_created, on: :create

      def broadcast_channel_created
        memberships.each do |membership|
          ChannelCreatedJob.perform_later(membership)
        end
      end
    end
  end
end
