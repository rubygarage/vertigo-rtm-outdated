require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe GroupsController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }
      let(:group) { create(:vertigo_rtm_group, creator: user) }
      let(:user) { create(:user) }

      include_context :controller_error_responses

      let(:members) { create_list(:user, 3) }

      context 'POST create' do
        let(:serialized_group_name) { (members + [user]).map(&:name).join(',') }
        let(:request_params) { { group: { member_ids: members.map(&:id) } } }
        let(:perform_request) { post :create, params: request_params }

        it_behaves_like :it_handles_unauthorized_user

        include_context :when_user_authorized

        context 'with valid params' do
          it 'responds with created http status' do
            perform_request
            expect(response).to have_http_status(:created)
          end

          it 'responds with resource json' do
            perform_request
            expect(json_response[:data][:attributes][:name]).to eq(serialized_group_name)
          end
        end
      end

      context 'GET show' do
        let(:serialized_group_name) { user.name }
        let(:request_params) { { id: group.id } }
        let(:perform_request) { get :show, params: request_params }

        include_context :when_user_authorized

        it 'responds with ok http status' do
          perform_request
          expect(response).to have_http_status(:ok)
        end

        it 'responds with resource json' do
          perform_request
          expect(json_response[:data][:attributes][:name]).to eq(serialized_group_name)
        end

        it_behaves_like :it_handles_not_found_error do
          let(:request_params) { { id: 1234 } }
        end
        it_behaves_like :it_handles_forbidden_error
        it_behaves_like :it_handles_unauthorized_user
      end
    end
  end
end
