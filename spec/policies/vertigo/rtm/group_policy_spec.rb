require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe GroupPolicy do
      include_context :for_conversation_policy, :group
      it_behaves_like :conversation_permissions
    end
  end
end
