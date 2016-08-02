module Vertigo
  module Rtm
    class MessagePolicy < ApplicationPolicy
      def update?
        creator?
      end

      def destroy?
        creator?
      end

      private

      def creator?
        record.creator_id == user.id
      end
    end
  end
end
