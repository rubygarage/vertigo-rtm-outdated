module Vertigo
  module Rtm
    class Message < Vertigo::Rtm::ApplicationRecord
      belongs_to :creator, class_name: Vertigo::Rtm.user_class
      belongs_to :conversation, counter_cache: true
      has_many   :attachments, dependent: :destroy, inverse_of: :message

      validates :text, presence: true

      scope :unread_by, (lambda do |user_id|
        query = <<-SQL
          vertigo_rtm_memberships.user_id = ?
          AND vertigo_rtm_messages.created_at > vertigo_rtm_memberships.last_read_at
        SQL
        joins(conversation: :memberships).where(query, user_id).distinct
      end)

      accepts_nested_attributes_for :attachments

      after_commit :notify_on_create, on: :create
      after_commit :notify_on_update, on: :update
      after_commit :notify_on_delete, on: :destroy

      private

      def notify_on_create
        Vertigo::Rtm::EventJob.perform_later('message.created', id)
      end

      def notify_on_update
        Vertigo::Rtm::EventJob.perform_later('message.updated', id)
      end

      def notify_on_delete
        Vertigo::Rtm::EventJob.perform_later('message.deleted', id)
      end
    end
  end
end
