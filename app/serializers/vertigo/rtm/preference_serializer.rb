module Vertigo
  module Rtm
    class PreferenceSerializer < ApplicationSerializer
      type 'preferences'

      attributes :notify_on_message, :notify_on_mention, :highlight_words, :muted

      link :self do
        if object.user?
          scope.preference_url
        else
          scope.conversation_preference_url(object.preferenceable.conversation.id)
        end
      end
    end
  end
end
