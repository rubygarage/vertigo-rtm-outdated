require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ConversationsController, type: :controller do
      routes { Vertigo::Rtm::Engine.routes }

      let(:current_user) { create(:user) }

      include_context :controller_error_responses

      before { allow(controller).to receive(:vertigo_rtm_current_user).and_return(current_user) }

      context 'GET index' do
        let(:perform_request) { get :index }

        context 'when user authorized' do
          before do
            allow_any_instance_of(ConversationPresenter).to receive(:id).and_return('1234')
            perform_request
          end

          it { expect(response).to be_ok }

          it do
            expect(response).to serialize_resource(ConversationPresenter.new(current_user))
              .with(Vertigo::Rtm::ConversationPresenterSerializer)
              .as(:singular)
              .and_options(include: [:current_user, :groups, :channels])
          end
        end

        it_behaves_like :it_handles_unauthorized_user
      end
    end
  end
end
