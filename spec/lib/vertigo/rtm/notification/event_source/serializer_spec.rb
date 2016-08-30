require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Notification::EventSource::Serializer do
      let(:conversation) { create(:vertigo_rtm_conversation) }
      let(:event_source) { double(:event_source) }
      let(:view_context) { double(:view_context) }

      subject(:subject) do
        described_class.new(event_source, serializer: Vertigo::Rtm::ChannelSerializer, scope: view_context)
      end

      before do
        allow(event_source).to receive(:event_name).and_return('conversation.created')
        allow(event_source).to receive(:payload).and_return(conversation)
      end

      context '#attributes' do
        let(:serializable_resource) { double(:serializable_resource) }
        let(:serializable_options) do
          {
            adapter: ActiveModelSerializers::Adapter::JsonApi,
            key_transform: :camel_lower,
            serializer: Vertigo::Rtm::ChannelSerializer,
            scope: view_context
          }
        end

        before do
          expect(ActiveModelSerializers::SerializableResource).to receive(:new)
            .with(event_source.payload, serializable_options)
            .and_return(serializable_resource)
          expect(serializable_resource).to receive(:as_json).and_return(data: { id: conversation.id })
        end

        it 'has next keys & values' do
          attributes = subject.attributes

          expect(attributes.keys).to match_array([:event, :payload])
          expect(attributes.values).to match_array(['conversation.created', { data: { id: conversation.id } }])
        end
      end
    end
  end
end
