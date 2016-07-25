module Vertigo
  module Rtm
    class Ability
      include ::CanCan::Ability

      def initialize(user)
        user ||= Vertigo::Rtm.user_class.new

        can :read, Vertigo::Rtm.user_class
        can :update, Vertigo::Rtm.user_class, id: user.id
      end
    end
  end
end
