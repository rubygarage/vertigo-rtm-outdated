module Vertigo
  module Rtm
    class ChannelSerializer < Vertigo::Rtm::ConversationSerializer
      type 'channels'

      link :self do
        scope.channel_url(object.id)
      end
    end
  end
end
