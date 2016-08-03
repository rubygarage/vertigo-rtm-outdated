require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe PreferencePolicy do
      let(:user) { create(:user) }

      subject { described_class }

      context 'when preference userable' do
        let(:preference) { create(:vertigo_rtm_preference, preferenceable: user) }

        permissions :show? do
          it { is_expected.to permit(user, preference) }
          it { is_expected.not_to permit(NullUser.new, preference) }
        end

        permissions :update? do
          it { is_expected.to permit(user, preference) }
          it { is_expected.not_to permit(NullUser.new, preference) }
        end
      end

      context 'when preference membershipable' do
        let(:conversation) { create(:vertigo_rtm_conversation, creator: user) }
        let(:preference) { user.vertigo_rtm_conversation_preference(conversation.id) }

        permissions :show? do
          it { is_expected.to permit(user, preference) }
          it { is_expected.not_to permit(NullUser.new, preference) }
        end

        permissions :update? do
          it { is_expected.to permit(user, preference) }
          it { is_expected.not_to permit(NullUser.new, preference) }
        end
      end
    end
  end
end
