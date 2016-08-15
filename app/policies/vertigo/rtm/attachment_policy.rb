module Vertigo
  module Rtm
    class AttachmentPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        true
      end

      def show?
        true
      end
    end
  end
end
