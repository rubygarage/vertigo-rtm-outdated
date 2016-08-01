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

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(creator) }

      context 'POST create' do
        context 'creates channel' do
          before { post :create, params: { channel: { name: channel_attributes[:name] } } }

          it { expect(response).to be_created }

          it 'renders channel json' do
            expect(json_response[:data][:attributes][:name]).to eq(channel_attributes[:name])
          end
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            post :create, params: { channel: { name: channel_attributes[:name] } }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with unprocessable entity error' do
          before { post :create, params: { channel: { name: '' } } }

          it_behaves_like 'unprocessable entity error'
        end
      end

      context 'GET show' do
        context 'shows channel' do
          before { get :show, params: { id: channel.id } }

          it { expect(response).to be_ok }
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            get :show, params: { id: channel.id }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with forbidden error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(create(:user))
            get :show, params: { id: channel.id }
          end

          it_behaves_like 'forbidden error'
        end
      end

      context 'PUT update' do
        context 'updates channel' do
          before { put :update, params: { id: channel.id, channel: { name: channel_attributes[:name] } } }

          it { expect(response).to be_ok }

          it 'renders channel json' do
            expect(json_response[:data][:attributes][:name]).to eq(channel_attributes[:name])
          end
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            put :update, params: { id: channel.id, channel: { name: channel_attributes[:name] } }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with forbidden error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(member)
            put :update, params: { id: channel.id, channel: { name: channel_attributes[:name] } }
          end

          it_behaves_like 'forbidden error'
        end

        context 'fails with unprocessable entity error' do
          before { put :update, params: { id: channel.id, channel: { name: '' } } }

          it_behaves_like 'unprocessable entity error'
        end
      end

      context 'DELETE destroy' do
        context 'destroys channel' do
          before { delete :destroy, params: { id: channel.id } }

          it { expect(response).to be_no_content }
          it { expect(response.body).to be_empty }
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            delete :destroy, params: { id: channel.id }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with forbidden error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(member)
            delete :destroy, params: { id: channel.id }
          end

          it_behaves_like 'forbidden error'
        end
      end

      context 'PUT leave' do
        context 'leaves channel with success' do
          before { put :leave, params: { id: channel.id } }

          it { expect(response).to be_ok }
          it { expect(response.body).to be_empty }
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            put :leave, params: { id: channel.id }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with forbidden error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(create(:user))
            put :leave, params: { id: channel.id }
          end

          it_behaves_like 'forbidden error'
        end
      end

      context 'PUT kick' do
        context 'kicks member with success' do
          before { put :kick, params: { id: channel.id, member_id: member.id } }

          it { expect(response).to be_ok }
          it { expect(response.body).to be_empty }
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            put :kick, params: { id: channel.id, member_id: member.id }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with forbidden error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(member)
            put :kick, params: { id: channel.id, member_id: member.id }
          end

          it_behaves_like 'forbidden error'
        end

        context 'fails with not found error' do
          before { put :kick, params: { id: channel.id, member_id: 1234 } }

          it_behaves_like 'not found error'
        end
      end

      context 'PUT invite' do
        context 'invites user with success' do
          before { put :invite, params: { id: channel.id, member_id: new_member.id } }

          it { expect(response).to be_ok }
          it 'renders channel json' do
            expect(json_response[:data][:attributes][:name]).to eq(channel.name)
          end
        end

        context 'fails with unauthorized error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(nil)
            put :invite, params: { id: channel.id, member_id: new_member.id }
          end

          it_behaves_like 'unauthorized error'
        end

        context 'fails with forbidden error' do
          before do
            allow(controller).to receive(:vertigo_rtm_current_user).and_return(create(:user))
            put :invite, params: { id: channel.id, member_id: new_member.id }
          end

          it_behaves_like 'forbidden error'
        end

        context 'fails with unprocessable entity error' do
          before { put :invite, params: { id: channel.id, member_id: 1234 } }

          it_behaves_like 'unprocessable entity error'
        end
      end
    end
  end
end
