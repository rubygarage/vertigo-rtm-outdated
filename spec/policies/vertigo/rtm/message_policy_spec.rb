require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe MessagePolicy do
      subject { described_class }

      let(:user) { create(:user) }
      let(:creator) { create(:user) }
      let(:message) { create(:vertigo_rtm_message, creator: creator) }

      permissions :update? do
        it { is_expected.to permit(creator, message) }
        it { is_expected.not_to permit(user, message) }
      end

      permissions :destroy? do
        it { is_expected.to permit(creator, message) }
        it { is_expected.not_to permit(user, message) }
      end
    end
  end
end
