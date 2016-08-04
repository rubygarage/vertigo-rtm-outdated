require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Group, type: :model do
      subject(:group) { create(:vertigo_rtm_group) }

      context 'associations' do
        it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to have_many(:memberships).dependent(:destroy) }
        it { is_expected.to have_many(:memberships).dependent(:destroy).inverse_of(:conversation) }
        it do
          is_expected.to have_many(:members)
            .through(:memberships)
            .class_name(Vertigo::Rtm.user_class.to_s)
            .source(:user)
        end
        it { is_expected.to have_many(:messages).dependent(:destroy) }
      end

      context 'validations' do
        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_uniqueness_of(:name) }
        it { is_expected.to define_enum_for(:state).with([:unarchived, :archived]) }
      end

      context 'methods' do
        context '#group?' do
          it { is_expected.to be_group }
        end

        context '#channel?' do
          it { is_expected.not_to be_channel }
        end
      end
    end

    context 'callbacks' do
      context 'after commit' do
        context '#ensure_user_conversation_relation' do
          let(:user) { create(:user) }
          let(:group) { build(:vertigo_rtm_group, creator: user) }

          it 'creates user_conversation relation for creator' do
            group.save

            expect(group.reload.members_count).to eq(1)
          end

          it 'is called after commit' do
            allow(group).to receive(:ensure_user_conversation_relation)

            group.run_callbacks(:commit)

            expect(group).to have_received(:ensure_user_conversation_relation)
          end
        end
      end
    end
  end
end
