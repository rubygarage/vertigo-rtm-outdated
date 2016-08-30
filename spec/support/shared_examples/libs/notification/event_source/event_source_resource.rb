RSpec.shared_context :event_source_resource do
  subject(:subject) { described_class.new(event_name, resource.id) }

  RSpec.shared_examples :has_next_getters do
    context '#event_name' do
      it { expect(subject.event_name).to eq(event_name) }
    end

    context '#resource_id' do
      it { expect(subject.resource_id).to eq(resource.id) }
    end

    context '#payload' do
      it { expect(subject.payload).to eq(resource) }
    end
  end

  RSpec.shared_examples :has_next_target_users do
    context '#target_users' do
      it 'returns users' do
        expect(subject.target_users).to match_array(expected_users)
      end

      it 'does not contain payload maker' do
        expect(subject.target_users).not_to include(payload_maker)
      end
    end
  end

  RSpec.shared_examples :as_json do |options = {}|
    context '#as_json' do
      let(:recepient) { create(:user) }
      let(:serializer) { double(:serializes) }
      let(:view_context) { double(:view_context) }
      let(:default_options) { { scope: view_context }.merge(options) }

      it 'serializes event' do
        expect(Vertigo::Rtm::ViewContext).to receive(:new).with(recepient) { view_context }
        expect(Vertigo::Rtm::Notification::EventSource::Serializer).to receive(:new)
          .with(subject, default_options)
          .and_return(serializer)
        expect(serializer).to receive(:attributes)

        subject.as_json(recepient)
      end
    end
  end
end
