module Vertigo
  module Rtm
    class Group < Vertigo::Rtm::Conversation
      validates :name, uniqueness: true
      before_validation :set_name

      private

      def set_name
        self[:name] = (member_ids | [creator_id]).sort.join('-')
      end
    end
  end
end
