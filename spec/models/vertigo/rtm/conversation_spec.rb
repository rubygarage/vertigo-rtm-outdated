require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Conversation, type: :model do
      subject(:conversation) { create(:vertigo_rtm_conversation) }

      it_behaves_like :per_page

      context 'associations' do
        it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to have_many(:memberships).dependent(:destroy).inverse_of(:conversation) }
        it { is_expected.to have_many(:members).through(:memberships).source(:user) }
        it { is_expected.to have_many(:messages).dependent(:destroy) }
        it { is_expected.to have_many(:attachments).through(:messages) }
      end

      context 'validations' do
        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_uniqueness_of(:name) }
        it { is_expected.to define_enum_for(:state).with([:unarchived, :archived]) }
      end

      context 'methods' do
        context '#group?' do
          it { is_expected.not_to be_group }
        end

        context '#channel?' do
          it { is_expected.not_to be_channel }
        end

        include_context :changeable_enums
        it_behaves_like :it_has_enums_with_raising_exceptions, :state
      end
    end

    context 'callbacks' do
      context 'after commit' do
        context '#ensure_user_conversation_relation' do
          let(:user) { create(:user) }
          let(:conversation) { build(:vertigo_rtm_conversation, creator: user) }

          it 'creates user_conversation relation for creator' do
            conversation.save

            expect(conversation.reload.members_count).to eq(1)
          end

          it 'is called after commit' do
            allow(conversation).to receive(:ensure_user_conversation_relation)

            conversation.valid?
            expect(conversation).not_to have_received(:ensure_user_conversation_relation)
            conversation.run_callbacks(:save)
            expect(conversation).not_to have_received(:ensure_user_conversation_relation)
            conversation.save
            expect(conversation).to have_received(:ensure_user_conversation_relation)
          end
        end
      end
    end
  end
end
