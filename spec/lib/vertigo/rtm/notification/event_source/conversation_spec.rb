require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Notification::EventSource::Conversation do
      include_context :event_source_resource do
        let(:resource) { create(:vertigo_rtm_conversation) }
        let(:event_name) { 'conversation.created' }

        it_behaves_like :has_next_getters

        it_behaves_like :has_next_target_users do
          let(:expected_users) { [create(:user, :online)] }
          let(:payload_maker) { resource.creator }

          before do
            resource.members << expected_users
          end
        end

        it_behaves_like :as_json
      end
    end
  end
end
