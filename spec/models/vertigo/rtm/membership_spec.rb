require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Membership, type: :model do
      subject(:membership) { create(:vertigo_rtm_membership) }

      context 'associations' do
        it { is_expected.to belong_to(:user).class_name(Vertigo::Rtm.user_class.to_s) }
        it { is_expected.to belong_to(:conversation).counter_cache(:members_count) }
        it { is_expected.to have_one(:preference).class_name('Vertigo::Rtm::Preference').dependent(:destroy) }
      end

      context 'validations' do
        it { is_expected.to validate_presence_of(:last_read_at) }
      end

      context 'methods' do
      end

      context 'callbacks' do
        context 'after commit' do
          context '#create_preference' do
            let(:user) { create(:user) }
            let(:membership) { build(:vertigo_rtm_membership, user: user) }

            it 'creates preference for membership' do
              expect { membership.save }.to change { user.vertigo_rtm_conversation_preferences.count }.from(0).to(1)
            end

            it 'is called after commit' do
              allow(membership).to receive(:create_preference)

              membership.run_callbacks(:commit)

              expect(membership).to have_received(:create_preference)
            end
          end
        end
      end
    end
  end
end
