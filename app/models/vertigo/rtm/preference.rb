module Vertigo
  module Rtm
    class Preference < ApplicationRecord
      belongs_to :preferenceable, polymorphic: true

      def userable?
        preferenceable_type.demodulize == Vertigo::Rtm.user_class.name
      end

      def membershipable?
        preferenceable_type.demodulize == 'Membership'
      end
    end
  end
end
