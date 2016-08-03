require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ConversationPolicy do
      subject { described_class }

      let(:user) { create(:user) }
      let(:creator) { create(:user) }
      let(:member) { create(:user, conversation_user_relations: [relation]) }
      let(:conversation) { create(:vertigo_rtm_conversation, creator: creator) }

      let(:relation) do
        build(
          :vertigo_rtm_conversation_user_relation,
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
