require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe ConversationPresenter do
      let(:user) { create(:user) }
      let!(:channel) { create(:vertigo_rtm_channel, creator: user) }
      let!(:group) { create(:vertigo_rtm_group, creator: user) }
      subject(:subject) { described_class.new(user) }

      context '#id' do
        it 'returns object id' do
          expect(subject.id).to eq(subject.object_id)
        end
      end

      context '#current_user' do
        it 'returns current user' do
          expect(subject.current_user).to eq(user)
        end
      end

      context '#groups' do
        it 'returns groups' do
          expect(subject.groups).to match_array(group)
        end
      end

      context '#channels' do
        it 'returns channels' do
          expect(subject.channels).to match_array(channel)
        end
      end

      context '.model_name' do
        it 'returns active model name object' do
          expect(ActiveModel::Name).to receive(:new).with(described_class)

          described_class.model_name
        end
      end
    end
  end
end
