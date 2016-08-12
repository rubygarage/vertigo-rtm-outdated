require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe AttachmentPolicy do
      subject { described_class }
      let(:user) { NullUser.new }

      let!(:attachment) { create(:vertigo_rtm_attachment) }

      permissions :index? do
        it { is_expected.to permit(user, attachment) }
      end

      permissions :show? do
        it { is_expected.to permit(user, attachment) }
      end

      permissions '.scope' do
        let(:policy_scope) { AttachmentPolicy::Scope.new(user, Attachment.all).resolve }

        it 'returns attachments' do
          expect(policy_scope).to match_array([attachment])
        end
      end
    end
  end
end
