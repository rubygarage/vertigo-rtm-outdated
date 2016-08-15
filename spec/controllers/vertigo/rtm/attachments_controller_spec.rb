require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe AttachmentsController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }

      let(:current_user) { create(:user) }

      include_context :controller_error_responses

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(current_user) }

      let(:channel) { create(:vertigo_rtm_channel, creator: current_user) }
      let(:message) { create(:vertigo_rtm_message, conversation: channel) }
      let(:attachment) { create(:vertigo_rtm_attachment, message: message) }

      context 'GET index' do
        let(:request_params) { { conversation_id: channel.id } }
        let(:perform_request) { get :index, params: request_params }

        context 'shows attachment' do
          before { perform_request }

          it { expect(response).to be_ok }

          it do
            expect(response).to serialize_resource(channel.attachments.paginate(page: 1))
              .with(Vertigo::Rtm::AttachmentSerializer).as(:plural)
          end
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_not_found_error do
          let(:request_params) { { conversation_id: 1234 } }
        end
      end

      context 'GET show' do
        let(:request_params) { { conversation_id: channel.id, id: attachment.id } }
        let(:perform_request) { get :show, params: request_params }

        context 'shows attachment' do
          before { perform_request }

          it { expect(response).to be_ok }

          it do
            expect(response).to serialize_resource(attachment)
              .with(Vertigo::Rtm::AttachmentSerializer)
              .as(:singular)
          end
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_not_found_error do
          let(:request_params) { { conversation_id: 1234, id: attachment.id } }
        end
        it_behaves_like :it_handles_not_found_error do
          let(:request_params) { { conversation_id: channel.id, id: 1234 } }
        end
      end
    end
  end
end
