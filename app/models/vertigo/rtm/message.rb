module Vertigo
  module Rtm
    class Message < ApplicationRecord
      belongs_to :creator, class_name: Vertigo::Rtm.user_class
      belongs_to :conversation, counter_cache: true
      has_many   :attachments, dependent: :destroy

      validates :text, presence: true

      scope :unread_by, (lambda do |user_id|
        query = <<-SQL
          vertigo_rtm_conversation_user_relations.user_id = ?
          AND vertigo_rtm_messages.created_at > vertigo_rtm_conversation_user_relations.last_read_at
        SQL
        joins(conversation: :conversation_user_relations).where(query, user_id).distinct
      end)
    end
  end
end
