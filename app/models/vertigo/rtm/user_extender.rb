module Vertigo
  module Rtm
    module UserExtender
      extend ActiveSupport::Concern

      included do
        enum vertigo_rtm_status: { away: 0, online: 1, dnd: 2 }

        has_many :conversation_user_relations,
                 class_name: 'Vertigo::Rtm::ConversationUserRelation',
                 dependent: :destroy,
                 foreign_key: :user_id

        has_many :conversations,
                 through: :conversation_user_relations,
                 class_name: 'Vertigo::Rtm::Conversation'

        has_many :own_conversations,
                 class_name: 'Vertigo::Rtm::Conversation',
                 foreign_key: :creator_id

        has_many :groups,
                 class_name: 'Vertigo::Rtm::Group',
                 through: :conversation_user_relations,
                 source: :conversation

        has_many :channels,
                 class_name: 'Vertigo::Rtm::Channel',
                 through: :conversation_user_relations,
                 source: :conversation

        has_one :preference,
                as: :preferenceable,
                class_name: 'Vertigo::Rtm::Preference',
                dependent: :destroy

        has_many :conversation_preferences,
                 through: :conversation_user_relations,
                 class_name: 'Vertigo::Rtm::Preference'

        has_many :messages,
                 dependent: :destroy,
                 foreign_key: :user_id,
                 class_name: 'Vertigo::Rtm::Message'

        has_many :attachments,
                 through: :messages,
                 class_name: 'Vertigo::Rtm::Attachment'
      end

      class_methods do
        def policy_class
          Vertigo::Rtm::UserPolicy
        end
      end
    end
  end
end
