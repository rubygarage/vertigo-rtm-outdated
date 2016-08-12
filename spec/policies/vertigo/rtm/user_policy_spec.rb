require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe UserPolicy do
      let(:user) { create(:user) }

      subject { described_class }

      permissions :index? do
        it { is_expected.to permit(user, user) }
      end

      permissions :update? do
        it { is_expected.to permit(user, user) }
        it { is_expected.not_to permit(user, create(:user)) }
      end

      permissions '.scope' do
        let(:current_user) { create(:user) }
        let(:policy_scope) { UserPolicy::Scope.new(current_user, Vertigo::Rtm.user_class.all).resolve }

        it 'returns users except current user' do
          user = create(:user)
          expect(policy_scope).to eq([user])
        end
      end
    end
  end
end
