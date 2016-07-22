module Vertigo
  module Rtm
    class Conversation < ApplicationRecord
      enum status: { unarchive: 0, archive: 1 }

      has_many   :conversation_user_relations, dependent: :destroy
      has_many   :members, through: :conversation_user_relations, class_name: Vertigo::Rtm.user_class
      belongs_to :creator, class_name: Vertigo::Rtm.user_class, foreign_key: :creator_id
      has_many   :messages, dependent: :destroy

      validates :name, uniqueness: true, presence: true

      def group?
        false
      end

      def channel?
        false
      end
    end
  end
end
