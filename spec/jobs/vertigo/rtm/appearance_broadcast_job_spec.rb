require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe AppearanceBroadcastJob, type: :job do
      let(:user) { create(:user) }

      it_behaves_like :default_behaviour
      it_behaves_like :render_object do
        let(:options) do
          {
            json: user,
            serializer: Vertigo::Rtm::UserSerializer
          }
        end
      end

      subject(:job) { described_class.perform_later(user) }

      context '#perform' do
        it 'broadcasts into channel' do
          data = Vertigo::Rtm::ApplicationController.renderer.render(
            json: user,
            adapter: ActiveModelSerializers::Adapter::JsonApi,
            key_transform: :camel_lower,
            serializer: Vertigo::Rtm::UserSerializer
          )

          server = ActionCable.server
          expect(ActionCable).to receive(:server) { server }
          expect(server).to receive(:broadcast).with('vertigo:rtm:appearance', data)

          perform_enqueued_jobs { subject }
        end
      end
    end
  end
end
