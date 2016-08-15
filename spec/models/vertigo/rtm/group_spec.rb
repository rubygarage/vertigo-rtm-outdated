require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Group, type: :model do
      subject(:group) { create(:vertigo_rtm_group) }
      let(:another_user) { create(:user) }
      let(:creator) { create(:user) }
      let(:members) { create_list(:user, 3) }

      it_behaves_like :per_page

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
        it { is_expected.to define_enum_for(:state).with([:unarchived, :archived]) }

        context 'name' do
          let(:first_group) { build(:vertigo_rtm_group, members: members, creator: creator) }
          let(:second_group) { build(:vertigo_rtm_group, members: members, creator: creator) }
          let(:third_group) { build(:vertigo_rtm_group, members: members + [another_user], creator: creator) }

          it 'validates group member ids uniqueness' do
            first_group.save
            second_group.save
            third_group.save

            expect(second_group).to be_invalid
            expect(second_group.errors.details[:name].first[:error]).to eq(:taken)
            expect(third_group).to be_valid
          end
        end
      end

      context 'methods' do
        context '#group?' do
          it { is_expected.to be_group }
        end

        context '#channel?' do
          it { is_expected.not_to be_channel }
        end

        context '#set_name' do
          let(:group) { build(:vertigo_rtm_group, members: members, creator: creator) }

          it 'is called before validation' do
            allow(group).to receive(:set_name)

            group.valid?

            expect(group).to have_received(:set_name)
          end

          it 'sets name to member ids before validation' do
            expected_name = (members.map(&:id) | [creator.id]).sort.join('-')
            group.send(:set_name)

            expect(group.name).to eq(expected_name)
          end
        end

        include_context :changeable_enums
        it_behaves_like :it_has_enums_with_raising_exceptions, :state
      end
    end

    context 'callbacks' do
      context 'after commit' do
        context '#ensure_membership' do
          let(:user) { create(:user) }
          let(:group) { build(:vertigo_rtm_group, creator: user) }

          it 'creates user_conversation relation for creator' do
            group.save

            expect(group.reload.members_count).to eq(1)
          end

          it 'is called after commit' do
            allow(group).to receive(:ensure_membership)

            group.valid?
            expect(group).not_to have_received(:ensure_membership)
            group.run_callbacks(:save)
            expect(group).not_to have_received(:ensure_membership)
            group.save
            expect(group).to have_received(:ensure_membership)
          end
        end
      end
    end
  end
end
