module Vertigo
  module Rtm
    class Channel < Vertigo::Rtm::Conversation
      after_commit :notify_on_rename, on: :update, if: :name_previously_changed?
      after_commit :notify_on_status_change, on: :update, if: :state_previously_changed?

      define_callbacks :invite, :leave, :kick

      set_callback :invite, :after, :notify_on_invite
      set_callback :leave, :after, :notify_on_leave
      set_callback :kick, :after, :notify_on_kick

      def invite!(user_id)
        run_callbacks :invite do
          memberships.create!(user_id: user_id)
        end
      end

      def leave!(user_id)
        run_callbacks :leave do
          delete_membership!(user_id)
        end
      end

      def kick!(user_id)
        run_callbacks :kick do
          delete_membership!(user_id)
        end
      end

      private

      def notify_on_rename
        Vertigo::Rtm::EventJob.perform_later('channel.renamed', id)
      end

      def notify_on_status_change
        Vertigo::Rtm::EventJob.perform_later("channel.#{state}", id)
      end

      def notify_on_invite
        Vertigo::Rtm::EventJob.perform_later('channel.joined', id)
      end

      def notify_on_leave
        Vertigo::Rtm::EventJob.perform_later('channel.left', id)
      end

      def notify_on_kick
        Vertigo::Rtm::EventJob.perform_later('channel.kicked', id)
      end

      def delete_membership!(user_id)
        memberships.find_by!(user_id: user_id).destroy!
      end
    end
  end
end
