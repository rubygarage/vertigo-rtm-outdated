require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Notification::EventSource::Message do
      include_context :event_source_resource do
        let(:resource) { create(:vertigo_rtm_message) }
        let(:event_name) { 'message.created' }

        it_behaves_like :has_next_getters

        it_behaves_like :has_next_target_users do
          let(:expected_users) { [create(:user, :online)] }
          let(:payload_maker) { resource.creator }

          before do
            resource.conversation.members << expected_users
          end
        end

        it_behaves_like :as_json
      end
    end
  end
end
