module Vertigo
  module Rtm
    class PreferencePolicy < ApplicationPolicy
      def show?
        scope.where(id: record.id).exists?
      end

      def update?
        true
      end

      private

      def own_preference?
        @record.preferenceable_id = @user.id
      end
    end
  end
end
