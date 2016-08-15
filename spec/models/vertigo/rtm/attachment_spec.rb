require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Attachment, type: :model do
      subject(:attachment) { create(:vertigo_rtm_attachment) }

      it_behaves_like :per_page

      context 'associations' do
        it { is_expected.to belong_to(:message) }
      end

      context 'validations' do
      end

      context 'methods' do
      end
    end
  end
end
