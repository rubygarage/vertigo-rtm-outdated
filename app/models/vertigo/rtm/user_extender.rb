module Vertigo
  module Rtm
    module UserExtender
      extend ActiveSupport::Concern

      included do
        enum vertigo_rtm_status: { offline: 0, away: 1, online: 2, dnd: 3 }

        has_many :vertigo_rtm_memberships,
                 class_name: 'Vertigo::Rtm::Membership',
                 dependent: :destroy,
                 foreign_key: :user_id,
                 inverse_of: :user

        has_many :vertigo_rtm_conversations,
                 through: :vertigo_rtm_memberships,
                 class_name: 'Vertigo::Rtm::Conversation',
                 source: :conversation

        has_many :vertigo_rtm_own_conversations,
                 class_name: 'Vertigo::Rtm::Conversation',
                 foreign_key: :creator_id,
                 dependent: :destroy,
                 inverse_of: :creator

        has_many :vertigo_rtm_groups,
                 class_name: 'Vertigo::Rtm::Group',
                 through: :vertigo_rtm_memberships,
                 source: :conversation

        has_many :vertigo_rtm_channels,
                 class_name: 'Vertigo::Rtm::Channel',
                 through: :vertigo_rtm_memberships,
                 source: :conversation

        has_one :vertigo_rtm_preference,
                as: :preferenceable,
                class_name: 'Vertigo::Rtm::Preference',
                dependent: :destroy

        has_many :vertigo_rtm_conversation_preferences,
                 through: :vertigo_rtm_memberships,
                 class_name: 'Vertigo::Rtm::Preference',
                 source: :preference

        has_many :vertigo_rtm_messages,
                 dependent: :destroy,
                 foreign_key: :creator_id,
                 class_name: 'Vertigo::Rtm::Message',
                 inverse_of: :creator

        has_many :vertigo_rtm_attachments,
                 through: :vertigo_rtm_messages,
                 class_name: 'Vertigo::Rtm::Attachment'

        after_commit :ensure_broadcast_appearance, if: :id_or_status_previously_changed?

        protected

        def ensure_broadcast_appearance
          ## TODO
        end

        def id_or_status_previously_changed?
          id_previously_changed? || vertigo_rtm_status_previously_changed?
        end
      end

      class_methods do
        def policy_class
          Vertigo::Rtm::UserPolicy
        end
      end

      def vertigo_rtm_preference
        super || create_vertigo_rtm_preference
      end

      def vertigo_rtm_conversation_preference(conversation_id)
        vertigo_rtm_memberships
          .find_by!(conversation_id: conversation_id)
          .preference
      end
    end
  end
end
