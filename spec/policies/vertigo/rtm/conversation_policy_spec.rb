require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ConversationPolicy do
      subject { described_class }

      let(:user) { create(:user) }
      let(:creator) { create(:user) }
      let(:member) { create(:user, vertigo_rtm_memberships: [membership]) }
      let(:conversation) { create(:vertigo_rtm_conversation, creator: creator) }

      let(:membership) do
        build(
          :vertigo_rtm_membership,
          conversation: conversation
        )
      end

      permissions :index_message? do
        it { is_expected.to permit(creator, conversation) }
        it { is_expected.to permit(member, conversation) }
        it { is_expected.not_to permit(user, conversation) }
      end

      permissions :create_message? do
        it { is_expected.to permit(creator, conversation) }
        it { is_expected.to permit(member, conversation) }
        it { is_expected.not_to permit(user, conversation) }
      end
    end
  end
end
