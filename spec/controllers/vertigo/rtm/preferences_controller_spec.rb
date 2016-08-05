require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe PreferencesController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }

      let(:user) { create(:user) }
      let(:conversation) { create(:vertigo_rtm_conversation, creator: user) }

      include_context :controller_error_responses

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(user) }

      context 'GET show' do
        let(:perform_request) { get :show, params: request_params }

        context 'userable' do
          let(:request_params) { {} }

          context 'shows preference' do
            before { perform_request }

            it { expect(response).to be_ok }

            it do
              expect(response).to serialize_object(user.vertigo_rtm_preference)
                .with(Vertigo::Rtm::PreferenceSerializer)
            end
          end

          it_behaves_like :it_handles_unauthorized_user
        end

        context 'membershipable' do
          let(:request_params) { { conversation_id: conversation.id } }

          context 'shows preference' do
            before { perform_request }

            it { expect(response).to be_ok }

            it do
              expect(response).to serialize_object(user.vertigo_rtm_conversation_preference(conversation.id))
                .with(Vertigo::Rtm::PreferenceSerializer)
            end
          end

          it_behaves_like :it_handles_unauthorized_user
          it_behaves_like :it_handles_not_found_error do
            let(:request_params) { { conversation_id: 1234 } }
          end
        end
      end

      context 'PUT update' do
        let(:params) do
          {
            preference: {
              notify_on_message: false,
              notify_on_mention: false,
              highlight_words: '',
              muted: true
            }
          }
        end

        let(:perform_request) { put :update, params: request_params }

        context 'userable' do
          let(:request_params) { params }
          context 'updates preference' do
            before { perform_request }

            it { expect(response).to be_ok }

            it do
              expect(response).to serialize_object(user.vertigo_rtm_preference)
                .with(Vertigo::Rtm::PreferenceSerializer)
            end
          end

          it_behaves_like :it_handles_unauthorized_user
        end

        context 'membershipable' do
          let(:request_params) { params.merge(conversation_id: conversation.id) }

          context 'shows preference' do
            before { perform_request }

            it { expect(response).to be_ok }

            it do
              expect(response).to serialize_object(user.vertigo_rtm_conversation_preference(conversation.id))
                .with(Vertigo::Rtm::PreferenceSerializer)
            end
          end

          it_behaves_like :it_handles_unauthorized_user
        end
      end
    end
  end
end
