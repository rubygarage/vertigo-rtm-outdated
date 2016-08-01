module Vertigo
  module Rtm
    class NullUser
      def id
        0
      end

      def name
        'Anonymous User'
      end

      def policy_class
        Vertigo::Rtm::UserPolicy
      end
    end
  end
end
