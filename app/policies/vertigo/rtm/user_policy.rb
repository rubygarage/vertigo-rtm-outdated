module Vertigo
  module Rtm
    class UserPolicy < ApplicationPolicy
      class Scope < Scope
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
