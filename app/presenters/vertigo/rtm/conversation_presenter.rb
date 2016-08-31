module Vertigo
  module Rtm
    class ConversationPresenter
      attr_reader :current_user, :channels, :groups

      def initialize(current_user)
        @current_user = current_user
        @channels = current_user.vertigo_rtm_channels
        @groups = current_user.vertigo_rtm_groups
      end

      def self.model_name
        @_model_name ||= ::ActiveModel::Name.new(self)
      end

      def users
        Vertigo::Rtm.user_class.all
      end

      alias id object_id
      alias read_attribute_for_serialization send
    end
  end
end
