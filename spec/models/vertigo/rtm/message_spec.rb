require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe Message, type: :model do
    subject(:message) { create(:vertigo_rtm_message) }

    context 'associations' do
      it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
      it { is_expected.to belong_to(:conversation).counter_cache(true) }
    end

    context 'validations' do
    end

    context 'methods' do
    end
  end
end
