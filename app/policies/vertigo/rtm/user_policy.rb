module Vertigo
  module Rtm
    class UserPolicy < ApplicationPolicy
      class Scope < Scope
        attr_reader :user, :scope

        def initialize(user, scope)
          @user  = user
          @scope = scope
        end

        def resolve
          scope.all
        end
      end

      def index?
        true
      end

      def update?
        record.id == user.id
      end
    end
  end
end
