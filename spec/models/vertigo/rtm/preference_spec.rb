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
        context '#userable?' do
          it { expect(create(:vertigo_rtm_preference, :for_user)).to be_userable }
        end

        context '#membershipable?' do
          it { expect(create(:vertigo_rtm_preference, :for_membership)).to be_membershipable }
        end
      end
    end
  end
end
