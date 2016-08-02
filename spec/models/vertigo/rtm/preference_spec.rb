require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Preference, type: :model do
      subject(:preference) { create(:vertigo_rtm_preference) }

      context 'associations' do
        it { is_expected.to belong_to(:preferenceable) }
      end

      context 'validations' do
      end

      context 'methods' do
        context '#user?' do
          it { expect(create(:vertigo_rtm_preference, :for_user)).to be_user }
        end

        context '#conversation_user_relation?' do
          it { expect(create(:vertigo_rtm_preference, :for_conversation)).to be_conversation_user_relation }
        end
      end
    end
  end
end
