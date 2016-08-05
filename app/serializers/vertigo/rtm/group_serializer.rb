module Vertigo
  module Rtm
    class GroupSerializer < ConversationSerializer
      type 'groups'

      attribute :name do
        object.members.pluck(Vertigo::Rtm.user_name_column).join(',')
      end

      link :self do
        scope.group_url(object.id)
      end
    end
  end
end
