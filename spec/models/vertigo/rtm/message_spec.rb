require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Message, type: :model do
      subject(:message) { create(:vertigo_rtm_message) }

      context 'associations' do
        it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to belong_to(:conversation).counter_cache(true) }
        it { is_expected.to have_many(:attachments).dependent(:destroy) }
      end

      context 'validations' do
      end

      context 'methods' do
      end
    end

    context 'scopes' do
      context '#unread_by' do
        let(:conversation) { create(:vertigo_rtm_conversation) }
        let!(:odd_message) do
          create(:vertigo_rtm_message, created_at: 2.days.ago)
        end
        let!(:old_message) do
          create(:vertigo_rtm_message, created_at: 4.days.ago, conversation: conversation)
        end
        let!(:new_message) do
          create(:vertigo_rtm_message, created_at: 2.days.ago, conversation: conversation)
        end
        let(:user) { create(:user) }

        before do
          membership = create(:vertigo_rtm_membership,
                              user: user,
                              conversation: conversation)
          membership.update_column(:last_read_at, 3.days.ago)
        end

        it 'returns messages not read by user' do
          expect(conversation.messages.unread_by(user.id)).to eq([new_message])
        end
      end
    end
  end
end
