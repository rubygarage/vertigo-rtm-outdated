RSpec.shared_context :for_conversation_policy do |conversation_type|
  let(:user) { create(:user) }
  let(:creator) { create(:user) }
  let(:member) { create(:user) }
  let(:conversation_object) { create(:"vertigo_rtm_#{conversation_type}", creator: creator, members: [member]) }
  let(:conversation_class) { "Vertigo::Rtm::#{conversation_type.to_s.classify}".constantize }

  subject(:policy_class) { described_class }

  RSpec.shared_examples :conversation_permissions do
    permissions :create? do
      it { is_expected.to permit(user, conversation_class) }
    end

    permissions :show? do
      it { is_expected.to permit(creator, conversation_object) }
      it { is_expected.to permit(member, conversation_object) }
      it { is_expected.not_to permit(user, conversation_object) }
    end

    permissions :update? do
      it { is_expected.to permit(creator, conversation_object) }
      it { is_expected.not_to permit(member, conversation_object) }
      it { is_expected.not_to permit(user, conversation_object) }
    end

    permissions :index_message? do
      it { is_expected.to permit(creator, conversation_object) }
      it { is_expected.to permit(member, conversation_object) }
      it { is_expected.not_to permit(user, conversation_object) }
    end

    permissions :create_message? do
      it { is_expected.to permit(creator, conversation_object) }
      it { is_expected.to permit(member, conversation_object) }
      it { is_expected.not_to permit(user, conversation_object) }
    end
  end
end
