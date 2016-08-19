require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Notification::EventSource::User do
      include_context :event_source_resource do
        let(:resource) { create(:user) }
        let(:event_name) { 'user.status.changed' }

        it_behaves_like :has_next_getters

        it_behaves_like :has_next_target_users do
          let!(:expected_users) { [create(:user, :online)] }
          let(:payload_maker) { resource }
        end

        it_behaves_like :as_json, serializer: Vertigo::Rtm::UserSerializer
      end
    end
  end
end
