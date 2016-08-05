require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Vertigo::Rtm::ChannelsController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }
      let(:creator) { create(:user) }
      let(:member) { create(:user) }
      let(:new_member) { create(:user) }
      let(:channel) { create(:vertigo_rtm_channel, creator: creator, members: [member]) }
      let(:channel_attributes) { attributes_for(:vertigo_rtm_channel) }
      include_context :controller_error_responses

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(creator) }

      context 'POST create' do
        let(:request_params) { { channel: { name: channel_attributes[:name] } } }
        let(:perform_request) { post :create, params: request_params }
        context 'creates channel' do
          it 'responds with created http status' do
            perform_request
            expect(response).to be_created
          end

          it 'renders channel json' do
            perform_request
            expect(json_response[:data][:attributes][:name]).to eq(channel_attributes[:name])
          end
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_unprocessable_entity_error do
          let(:request_params) { { channel: { name: '' } } }
        end
      end

      context 'GET show' do
        let(:request_params) { { id: channel.id } }
        let(:perform_request) { get :show, params: request_params }
        it 'responds with ok status' do
          perform_request
          expect(response).to be_ok
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
      end

      context 'PUT update' do
        let(:request_params) { { id: channel.id, channel: { name: channel_attributes[:name] } } }
        let(:perform_request) { put :update, params: request_params }

        it 'responds with ok status' do
          perform_request
          expect(response).to be_ok
        end

        it 'renders channel json' do
          perform_request
          expect(json_response[:data][:attributes][:name]).to eq(channel_attributes[:name])
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_unprocessable_entity_error do
          let(:request_params) { { id: channel.id, channel: { name: '' } } }
        end
      end

      context 'PUT archive' do
        let(:request_params) { { id: channel.id } }
        let(:perform_request) { put :archive, params: request_params }

        it 'responds with ok status' do
          perform_request
          expect(response).to be_ok
        end

        it 'returns empty body' do
          perform_request
          expect(response.body).to be_empty
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_unprocessable_entity_error do
          let(:channel) { create(:vertigo_rtm_channel, :archived, creator: creator, members: [member]) }
        end
      end

      context 'PUT unarchive' do
        let(:request_params) { { id: channel.id } }
        let(:channel) { create(:vertigo_rtm_channel, :archived, creator: creator, members: [member]) }
        let(:perform_request) { put :unarchive, params: request_params }

        it 'responds with ok status' do
          perform_request
          expect(response).to be_ok
        end

        it 'returns empty body' do
          perform_request
          expect(response.body).to be_empty
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_unprocessable_entity_error do
          let(:channel) { create(:vertigo_rtm_channel, :unarchived, creator: creator, members: [member]) }
        end
      end

      context 'PUT leave' do
        let(:request_params) { { id: channel.id } }
        let(:perform_request) { put :leave, params: request_params }

        it 'responds with ok status' do
          perform_request
          expect(response).to be_ok
        end

        it 'returns empty body' do
          perform_request
          expect(response.body).to be_empty
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
      end

      context 'PUT kick' do
        let(:request_params) { { id: channel.id, member_id: member.id } }
        let(:perform_request) { put :kick, params: request_params }

        it 'responds with status ok' do
          perform_request
          expect(response).to be_ok
        end

        it 'returns empty body' do
          perform_request
          expect(response.body).to be_empty
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_not_found_error do
          let(:request_params) { { id: channel.id, member_id: 1234 } }
        end
      end

      context 'PUT invite' do
        let(:request_params) { { id: channel.id, member_id: new_member.id } }
        let(:perform_request) { put :invite, params: request_params }

        it 'responds with ok status' do
          perform_request
          expect(response).to be_ok
        end

        it 'renders channel json' do
          perform_request
          expect(json_response[:data][:attributes][:name]).to eq(channel.name)
        end

        it_behaves_like :it_handles_unauthorized_user
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_unprocessable_entity_error do
          let(:request_params) { { id: channel.id, member_id: 1234 } }
        end
      end
    end
  end
end
