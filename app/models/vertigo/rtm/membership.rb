module Vertigo
  module Rtm
    class Membership < ApplicationRecord
      belongs_to :conversation, counter_cache: :members_count, inverse_of: :memberships
      belongs_to :user, class_name: Vertigo::Rtm.user_class, inverse_of: :vertigo_rtm_memberships
      has_one    :preference, as: :preferenceable, class_name: 'Vertigo::Rtm::Preference', dependent: :destroy

      validates :last_read_at, presence: true

      before_validation :mark_last_read_timestamp, on: :create

      after_commit :create_preference, on: :create

      protected

      def mark_last_read_timestamp
        self.last_read_at = Time.zone.now
      end
    end
  end
end
