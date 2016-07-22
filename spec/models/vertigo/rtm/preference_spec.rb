require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe Preference, type: :model do
    subject(:preference) { create(:vertigo_rtm_preference) }

    context 'Associations' do
      it { is_expected.to belong_to(:preferenceable) }
    end

    context 'Validations' do
    end

    context 'Methods' do
    end
  end
end
