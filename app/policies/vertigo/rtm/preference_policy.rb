module Vertigo
  module Rtm
    class PreferencePolicy < ApplicationPolicy
      def show?
        own_preference?
      end

      def update?
        own_preference?
      end

      private

      def own_preference?
        if record.user?
          record.preferenceable_id = user.id
        else
          record.preferenceable.user_id = user.id
        end
      end
    end
  end
end
