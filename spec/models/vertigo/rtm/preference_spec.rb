require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe Preference, type: :model do
    subject(:preference) { create(:vertigo_rtm_preference) }

    context 'associations' do
      it { is_expected.to belong_to(:preferenceable) }
    end

    context 'validations' do
    end

    context 'methods' do
    end
  end
end
