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
        let!(:conversation_policy) { Vertigo::Rtm::ConversationPolicy.new(user, conversation) }

        before do
          allow(Vertigo::Rtm::ConversationPolicy).to receive(:new).with(user, conversation) { conversation_policy }
        end

        context 'when can see conversation' do
          before do
            allow(conversation_policy).to receive(:show?) { true }
          end

          permissions :show? do
            it { is_expected.to permit(user, preference) }
            it { is_expected.not_to permit(NullUser.new, preference) }
          end

          permissions :update? do
            it { is_expected.to permit(user, preference) }
            it { is_expected.not_to permit(NullUser.new, preference) }
          end
        end

        context 'when cannot see conversation' do
          before do
            allow(conversation_policy).to receive(:show?) { false }
          end

          permissions :show? do
            it { is_expected.not_to permit(user, preference) }
          end

          permissions :update? do
            it { is_expected.not_to permit(user, preference) }
          end
        end
      end
    end
  end
end
