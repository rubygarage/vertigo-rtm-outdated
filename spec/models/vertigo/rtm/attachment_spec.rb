require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe Attachment, type: :model do
    subject(:attachment) { create(:vertigo_rtm_attachment) }

    context 'associations' do
      it { is_expected.to belong_to(:message) }
    end

    context 'validations' do
    end

    context 'methods' do
    end
  end
end
