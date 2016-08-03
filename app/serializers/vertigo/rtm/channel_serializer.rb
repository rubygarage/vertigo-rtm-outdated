module Vertigo
  module Rtm
    class ChannelSerializer < ConversationSerializer
      type 'channels'

      link :self do
        scope.channel_url(object.id)
      end
    end
  end
end
