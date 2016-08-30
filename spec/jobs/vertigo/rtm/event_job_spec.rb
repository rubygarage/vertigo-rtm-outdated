require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe EventJob, type: :job do
      let(:arguments) { ['channel.created', 23] }

      subject(:job) { described_class.perform_later(*arguments) }

      it_behaves_like :default_behaviour

      context '#perform' do
        let(:channel) { create(:vertigo_rtm_channel, id: 23) }
        let(:event_source) { double(:event_source) }
        let(:broadcast) { double(:broadcast) }

        it 'broadcasts into the channel' do
          expect(Vertigo::Rtm::Notification::EventSource).to receive(:for).with(*arguments) { event_source }
          expect(Vertigo::Rtm::Notification::Broadcast).to receive(:new).with(event_source) { broadcast }
          expect(broadcast).to receive(:call)

          perform_enqueued_jobs { subject }
        end
      end
    end
  end
end
