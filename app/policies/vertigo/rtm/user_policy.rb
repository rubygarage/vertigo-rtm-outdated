module Vertigo
  module Rtm
    class UserPolicy < Vertigo::Rtm::ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.where.not(id: user.id)
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
