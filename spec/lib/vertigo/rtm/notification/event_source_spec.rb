require 'rails_helper'

module Vertigo
  module Rtm
    RSpec.describe Notification::EventSource do
      context '.for' do
        [
          {
            event_source: Vertigo::Rtm::Notification::EventSource::Conversation,
            events: [
              'channel.created',
              'channel.renamed',
              'channel.archived',
              'channel.unarchived',
              'channel.joined',
              'channel.left',
              'channel.kicked'
            ]
          },
          {
            event_source: Vertigo::Rtm::Notification::EventSource::Conversation,
            events: ['group.created']
          },
          {
            event_source: Vertigo::Rtm::Notification::EventSource::Message,
            events: [
              'message.created',
              'message.updated',
              'message.deleted'
            ]
          },
          {
            event_source: Vertigo::Rtm::Notification::EventSource::User,
            events: ['user.status.changed']
          }
        ].each do |item|
          item[:events].each do |event|
            context "when event name #{event}" do
              it { expect(described_class.for(event, 23)).to be_an_instance_of(item[:event_source]) }
            end
          end
        end
      end
    end
  end
end
