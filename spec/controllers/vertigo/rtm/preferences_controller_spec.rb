require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe PreferencesController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }

      let(:user) { create(:user) }
      let(:conversation) { create(:vertigo_rtm_conversation, creator: user) }

      include_context 'controller error responses'

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(user) }

      context 'GET show' do
        context 'userable' do
          context 'shows preference' do
            before { get :show }

            it { expect(response).to be_ok }
          end

          context 'fails with unauthorized error' do
            before do
              allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
              get :show
            end

            it_behaves_like 'API error', :unauthorized
          end
        end

        context 'membershipable' do
          context 'shows preference' do
            before { get :show, params: { conversation_id: conversation.id } }

            it { expect(response).to be_ok }
          end

          context 'fails with unauthorized error' do
            before do
              allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
              get :show, params: { conversation_id: conversation.id }
            end

            it_behaves_like 'API error', :unauthorized
          end

          context 'fails with not found error' do
            before do
              allow(controller).to receive(:vertigo_rtm_current_user).and_return(create(:user))
              get :show, params: { conversation_id: conversation.id }
            end

            it_behaves_like 'API error', :not_found
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

        context 'userable' do
          context 'updates preference' do
            before { put :update, params: params }

            it { expect(response).to be_ok }

            it 'renders preference json' do
              expect(json_response[:data][:attributes][:muted]).to eq(params[:preference][:muted])
            end
          end

          context 'fails with unauthorized error' do
            before do
              allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
              put :update, params: params
            end

            it_behaves_like 'API error', :unauthorized
          end
        end

        context 'membershipable' do
          context 'shows preference' do
            before { put :update, params: params.merge(conversation_id: conversation.id) }

            it { expect(response).to be_ok }

            it 'renders preference json' do
              expect(json_response[:data][:attributes][:muted]).to eq(params[:preference][:muted])
            end
          end

          context 'fails with unauthorized error' do
            before do
              allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
              put :update, params: params.merge(conversation_id: conversation.id)
            end

            it_behaves_like 'API error', :unauthorized
          end
        end
      end
    end
  end
end
