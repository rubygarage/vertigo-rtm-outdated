require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe Message, type: :model do
    subject(:message) { create(:vertigo_rtm_message) }

    context 'Associations' do
      it { is_expected.to belong_to(:creator).class_name(Vertigo::Rtm.user_class.to_s) }
      it { is_expected.to belong_to(:conversation).counter_cache(true) }
    end

    context 'Validations' do
    end

    context 'Methods' do
    end
  end
end
