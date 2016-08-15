require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe UsersController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }

      let(:current_user) { create(:user) }

      include_context :controller_error_responses

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(current_user) }

      context 'GET index' do
        def perform_request(params = {})
          get :index, params: params
        end

        context 'with search parameters' do
          let(:user) { create(:user) }
          let(:collection) { Vertigo::Rtm.user_class.where(id: user.id) }

          context 'when passing `user_ids`' do
            it do
              arguments = [array_including(user), hash_including(user_ids: [user.id.to_s])]
              expect(Vertigo::Rtm::UserQuery).to receive(:new).with(*arguments).and_call_original
              perform_request(user_ids: [user.id])
            end

            it do
              perform_request(user_ids: [user.id])
              expect(response).to be_ok
            end

            it do
              perform_request(user_ids: [user.id])
              expect(response).to serialize_resource(collection).with(Vertigo::Rtm::UserSerializer).as(:plural)
            end
          end

          context 'when passing `q`' do
            it do
              arguments = [array_including(user), hash_including(q: user.name)]
              expect(Vertigo::Rtm::UserQuery).to receive(:new).with(*arguments).and_call_original
              perform_request(q: user.name)
            end

            it do
              perform_request(q: user.name)
              expect(response).to be_ok
            end

            it do
              perform_request(q: user.name)
              expect(response).to serialize_resource(collection).with(Vertigo::Rtm::UserSerializer).as(:plural)
            end
          end
        end

        context 'without search parameters' do
          before do
            perform_request
          end

          it { expect(response).to be_ok }

          it do
            expect(response).to serialize_resource(Vertigo::Rtm.user_class.none)
              .with(Vertigo::Rtm::UserSerializer)
              .as(:plural)
          end
        end

        it_behaves_like :it_handles_unauthorized_user
      end

      context 'PUT update' do
        let(:params) do
          {
            id: current_user.id,
            user: {
              vertigo_rtm_status: :away
            }
          }
        end
        let(:perform_request) { put :update, params: params }

        context 'updates user' do
          before { perform_request }

          it { expect(response).to be_ok }

          it do
            expect(response).to serialize_resource(current_user).with(Vertigo::Rtm::UserSerializer).as(:singular)
          end
        end

        it_behaves_like :it_handles_unauthorized_user
      end
    end
  end
end
