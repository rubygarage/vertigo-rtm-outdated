RSpec.shared_context :controller_authorization do
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
end
