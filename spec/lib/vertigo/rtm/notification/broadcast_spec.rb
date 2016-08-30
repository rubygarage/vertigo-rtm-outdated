require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Notification::Broadcast do
      let(:event_source) { double(:event_source) }
      let(:target_user) { create(:user) }
      let(:payload) { { evet_name: 'user.wait' } }
      let(:server) { double(:server) }

      subject(:subject) { described_class.new(event_source) }

      before do
        allow(event_source).to receive(:target_users).and_return([target_user])
        allow(event_source).to receive(:as_json).with(target_user).and_return(payload)
      end

      context '#call' do
        it 'broadcasts into the channel' do
          expect(ActionCable).to receive(:server).and_return(server)
          expect(server).to receive(:broadcast).with("vertigo:rtm:event:#{target_user.id}", payload)

          subject.call
        end
      end
    end
  end
end
