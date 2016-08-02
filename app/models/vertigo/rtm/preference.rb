module Vertigo
  module Rtm
    class Preference < ApplicationRecord
      belongs_to :preferenceable, polymorphic: true

      def user?
        preferenceable_type.demodulize == Vertigo::Rtm.user_class.name
      end

      def conversation_user_relation?
        preferenceable_type.demodulize == 'ConversationUserRelation'
      end
    end
  end
end
