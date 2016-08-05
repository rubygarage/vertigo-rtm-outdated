require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ConversationPolicy do
      include_context :for_conversation_policy, :conversation
      it_behaves_like :conversation_permissions
    end
  end
end
