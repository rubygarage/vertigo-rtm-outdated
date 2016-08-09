module Vertigo
  module Rtm
    class UserSerializer < Vertigo::Rtm::ApplicationSerializer
      attributes Vertigo::Rtm.user_name_column

      attribute :status do
        object.vertigo_rtm_status
      end
    end
  end
end
