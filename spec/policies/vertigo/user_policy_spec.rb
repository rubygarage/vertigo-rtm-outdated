require 'rails_helper'

module Vertigo::Rtm
  RSpec.describe UserPolicy do
    let(:user) { create(:user) }

    subject { described_class }

    permissions '.scope' do
    end

    permissions :index? do
      it { expect(subject).to permit(user, user) }
    end

    permissions :update? do
      it { expect(subject).to permit(user, user) }
      it { expect(subject).not_to permit(user, create(:user)) }
    end
  end
end
