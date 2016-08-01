module Vertigo
  module Rtm
    class ChannelPolicy < ApplicationPolicy
      def create?
        true
      end

      def show?
        member?
      end

      def update?
        creator?
      end

      def leave?
        member?
      end

      def kick?
        creator?
      end

      def invite?
        member?
      end

      def destroy?
        creator?
      end

      private

      def creator?
        record.creator_id == user.id
      end

      def member?
        creator? || record.members.exists?(id: user.id)
      end
    end
  end
end
