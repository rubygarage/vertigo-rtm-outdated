require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe MessagesController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }

      include_context 'controller error responses'
      include_context :controller_authorization

      let(:conversation) { create(:vertigo_rtm_conversation) }
      let(:user) { create(:user, vertigo_rtm_conversations: [conversation]) }
      let(:invalid_message_params) { valid_message_params.merge(text: '') }

      let(:valid_message_params) do
        attributes_for(:vertigo_rtm_message).merge(
          attachments_attributes: [attributes_for(:vertigo_rtm_attachment)]
        )
      end

      shared_examples :it_handles_unauthorized_user do
        context 'when user is not authorized' do
          include_context :when_user_is_not_authorized

          before { perform_request }

          it_behaves_like 'API error', :unauthorized
        end
      end

      context 'GET index' do
        def perform_request
          params = {
            conversation_id: conversation.id
          }

          get :index, params: params
        end

        let!(:message) { create(:vertigo_rtm_message, creator: user, conversation: conversation) }

        it_behaves_like :it_handles_unauthorized_user

        context 'when user authorized' do
          include_context :when_user_authorized

          it 'responds with ok http status' do
            perform_request
            expect(response).to have_http_status(:ok)
          end

          it 'responds with resource json' do
            perform_request
            expect(json_response[:data].first[:attributes][:text]).to eq(message.text)
          end
        end
      end

      context 'POST create' do
        def perform_request
          params = {
            format: :json,
            conversation_id: conversation.id,
            message: message_params
          }

          post :create, params: params
        end

        let(:message_params) { nil }

        it_behaves_like :it_handles_unauthorized_user

        context 'when user authorized' do
          include_context :when_user_authorized

          context 'with valid params' do
            let(:message_params) { valid_message_params }

            it 'responds with created http status' do
              perform_request
              expect(response).to have_http_status(:created)
            end

            it 'creates message' do
              expect { perform_request }.to change { Message.count }.by(1)
              message = Message.last
              expect(message.conversation).to eq(conversation)
              expect(message.creator).to eq(user)
            end

            it 'creates message with attachment' do
              expect { perform_request }.to change { Attachment.count }.by(1)
              expect(Attachment.last.message).to eq Message.last
            end

            it 'responds with resource json' do
              perform_request
              expect(json_response[:data][:attributes][:text]).to eq(message_params[:text])
            end
          end

          context 'with invalid params' do
            let(:message_params) { invalid_message_params }

            it 'does not create message' do
              expect { perform_request }.not_to change { Message.count }
            end

            context 'when request performed' do
              before { perform_request }

              it_behaves_like 'API error', :unprocessable_entity
            end
          end
        end
      end

      context 'PUT update' do
        def perform_request
          params = {
            conversation_id: conversation.id,
            id: message.id,
            message: message_params
          }

          put :update, params: params
        end

        let(:message_params) { nil }

        let!(:message) do
          create(:vertigo_rtm_message,
                 creator: user,
                 conversation: conversation)
        end

        it_behaves_like :it_handles_unauthorized_user

        context 'when user is authorized' do
          include_context :when_user_authorized

          context 'with valid params' do
            let(:message_params) { valid_message_params }

            it 'responds with ok http status' do
              perform_request
              expect(response).to have_http_status(:ok)
            end

            it 'updates message' do
              expect { perform_request }
                .to change { message.reload.text }
                .from(message.text).to message_params[:text]
            end

            it 'responds with resource json' do
              perform_request
              expect(json_response[:data][:attributes][:text]).to eq(message_params[:text])
            end
          end

          context 'with invalid params' do
            let(:message_params) { invalid_message_params }

            it 'does not update message' do
              expect { perform_request }.not_to change { message.reload.text }
            end

            context 'when request performed' do
              before { perform_request }

              it_behaves_like 'API error', :unprocessable_entity
            end
          end
        end
      end

      context 'DELETE destroy' do
        def perform_request
          params = {
            conversation_id: conversation.id,
            id: message.id
          }

          delete :destroy, params: params
        end

        let!(:message) do
          create(:vertigo_rtm_message,
                 creator: user,
                 conversation: conversation)
        end

        it_behaves_like :it_handles_unauthorized_user

        context 'when_user_authorized' do
          include_context :when_user_authorized

          it 'deletes message' do
            expect { perform_request }.to change { Message.count }.by(-1)
          end

          it 'responds with no_content http status' do
            perform_request
            expect(response).to have_http_status(:no_content)
          end

          it 'responds with empty body' do
            perform_request
            expect(response.body).to be_blank
          end
        end
      end
    end
  end
end
