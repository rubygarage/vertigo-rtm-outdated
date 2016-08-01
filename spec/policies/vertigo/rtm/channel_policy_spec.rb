require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ChannelPolicy do
      let(:user) { create(:user) }
      let(:creator) { create(:user) }
      let(:member) { create(:user) }
      let(:channel) { create(:vertigo_rtm_channel, creator: creator, members: [member]) }

      subject { described_class }

      permissions :create? do
        it { is_expected.to permit(user, Channel) }
      end

      permissions :show? do
        it { is_expected.to permit(creator, channel) }
        it { is_expected.to permit(member, channel) }
        it { is_expected.not_to permit(user, channel) }
      end

      permissions :update? do
        it { is_expected.to permit(creator, channel) }
        it { is_expected.not_to permit(member, channel) }
        it { is_expected.not_to permit(user, channel) }
      end

      permissions :destroy? do
        it { is_expected.to permit(creator, channel) }
        it { is_expected.not_to permit(member, channel) }
        it { is_expected.not_to permit(user, channel) }
      end

      permissions :kick? do
        it { is_expected.to permit(creator, channel) }
        it { is_expected.not_to permit(member, channel) }
        it { is_expected.not_to permit(user, channel) }
      end

      permissions :leave? do
        it { is_expected.to permit(creator, channel) }
        it { is_expected.to permit(member, channel) }
        it { is_expected.not_to permit(user, channel) }
      end

      permissions :invite? do
        it { is_expected.to permit(creator, channel) }
        it { is_expected.to permit(member, channel) }
        it { is_expected.not_to permit(user, channel) }
      end
    end
  end
end
