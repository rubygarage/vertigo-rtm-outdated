module Vertigo
  module Rtm
    class Conversation < Vertigo::Rtm::ApplicationRecord
      enum state: { unarchived: 0, archived: 1 }

      has_many   :memberships, dependent: :destroy, inverse_of: :conversation
      has_many   :members, through: :memberships, source: :user
      belongs_to :creator, class_name: Vertigo::Rtm.user_class, foreign_key: :creator_id
      has_many   :messages, dependent: :destroy
      has_many   :attachments, through: :messages

      validates :name, uniqueness: true, presence: true

      after_commit :ensure_user_conversation_relation, on: [:create]

      def group?
        self.class.name.demodulize == 'Group'
      end

      def channel?
        self.class.name.demodulize == 'Channel'
      end

      private

      def ensure_user_conversation_relation
        memberships.find_or_create_by(user_id: creator_id)
      end
    end
  end
end
