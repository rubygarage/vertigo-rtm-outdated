require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe UserPolicy do
      let(:user) { create(:user) }

      subject { described_class }

      permissions '.scope' do
      end

      permissions :index? do
        it { is_expected.to permit(user, user) }
      end

      permissions :update? do
        it { is_expected.to permit(user, user) }
        it { is_expected.not_to permit(user, create(:user)) }
      end
    end
  end
end
