require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ChannelPolicy do
      include_context :for_conversation_policy, :channel
      it_behaves_like :conversation_permissions

      permissions :kick? do
        it { is_expected.to permit(creator, conversation_object) }
        it { is_expected.not_to permit(member, conversation_object) }
        it { is_expected.not_to permit(user, conversation_object) }
      end

      permissions :leave? do
        it { is_expected.to permit(creator, conversation_object) }
        it { is_expected.to permit(member, conversation_object) }
        it { is_expected.not_to permit(user, conversation_object) }
      end

      permissions :invite? do
        it { is_expected.to permit(creator, conversation_object) }
        it { is_expected.to permit(member, conversation_object) }
        it { is_expected.not_to permit(user, conversation_object) }
      end

      permissions :archive? do
        it { is_expected.to permit(creator, conversation_object) }
        it { is_expected.not_to permit(member, conversation_object) }
        it { is_expected.not_to permit(user, conversation_object) }
      end

      permissions :unarchive? do
        it { is_expected.to permit(creator, conversation_object) }
        it { is_expected.not_to permit(member, conversation_object) }
        it { is_expected.not_to permit(user, conversation_object) }
      end
    end
  end
end
