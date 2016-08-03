RSpec.shared_context :controller_error_responses do
  RSpec.shared_examples :api_error do |status|
    before { perform_request }

    it "responds with :#{status} http status" do
      expect(response).to have_http_status(status)
    end

    it "renders #{status} error json" do
      expect(json_response[:errors].first[:title]).to eq(t("errors.#{status}", scope: 'vertigo.rtm'))
    end
  end

  RSpec.shared_context :when_user_authorized do |user_method = :user|
    before do
      allow(controller).to receive(:vertigo_rtm_current_user) { send(user_method) }
    end
  end

  RSpec.shared_context :when_user_is_not_authorized do
    before do
      allow(controller).to receive(:vertigo_rtm_current_user) { nil }
    end
  end

  RSpec.shared_context :when_user_is_forbidden do
    before do
      allow(controller).to receive(:vertigo_rtm_current_user) { create(:user) }
    end
  end

  RSpec.shared_examples :it_handles_unauthorized_user do
    context 'when user is not authorized' do
      include_context :when_user_is_not_authorized
      it_behaves_like :api_error, :unauthorized
    end
  end

  RSpec.shared_examples :it_handles_forbidden_error do
    context 'when user is forbidden to access resource' do
      include_context :when_user_is_forbidden
      it_behaves_like :api_error, :forbidden
    end
  end

  RSpec.shared_examples :it_handles_not_found_error do
    context 'when resource is not found' do
      it_behaves_like :api_error, :not_found
    end
  end

  RSpec.shared_examples :it_handles_unprocessable_entity_error do
    context 'when entity is unprocessable' do
      it_behaves_like :api_error, :unprocessable_entity
    end
  end
end
