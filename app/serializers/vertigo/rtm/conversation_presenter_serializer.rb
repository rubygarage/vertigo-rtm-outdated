module Vertigo
  module Rtm
    class ConversationPresenterSerializer < ::ActiveModel::Serializer
      type 'conversation_presenter'

      has_one :current_user, serializer: Vertigo::Rtm::UserSerializer
      has_many :channels
      has_many :groups
      has_many :users, serializer: Vertigo::Rtm::UserSerializer
    end
  end
end
