require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Channel, type: :model do
      subject(:channel) { create(:vertigo_rtm_channel) }

      context 'enums' do
        it { is_expected.to define_enum_for(:state).with([:unarchived, :archived]) }
      end

      context 'associations' do
        it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to have_many(:memberships).dependent(:destroy) }
        it do
          is_expected.to have_many(:members).through(:memberships)
            .class_name(Vertigo::Rtm.user_class.to_s)
        end
        it { is_expected.to have_many(:messages).dependent(:destroy) }
      end

      context 'validations' do
        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_uniqueness_of(:name) }
      end

      context 'methods' do
        context '#group?' do
          it { is_expected.not_to be_group }
        end

        context '#channel?' do
          it { is_expected.to be_channel }
        end
      end
    end

    context 'callbacks' do
      context 'after commit' do
        context '#ensure_user_conversation_relation' do
          let(:user) { create(:user) }
          let(:channel) { build(:vertigo_rtm_channel, creator: user) }

          it 'creates user_conversation relation for creator' do
            channel.save

            expect(channel.reload.members_count).to eq(1)
          end

          it 'is called after commit' do
            allow(channel).to receive(:ensure_user_conversation_relation)

            channel.run_callbacks(:commit)

            expect(channel).to have_received(:ensure_user_conversation_relation)
          end
        end
      end
    end
  end
end
