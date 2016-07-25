module Vertigo
  module Rtm
    class UserSerializer < ApplicationSerializer
      attributes Vertigo::Rtm.user_name_column
    end
  end
end
