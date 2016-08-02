FactoryGirl.define do
  factory :vertigo_rtm_conversation, class: 'Vertigo::Rtm::Conversation' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Conversation' }
    messages_count { 0 }
    members_count { 0 }

    association :creator, factory: :user

    trait :unarchived do
      state Vertigo::Rtm::Conversation.states[:unarchived]
    end

    trait :archived do
      state Vertigo::Rtm::Conversation.states[:archived]
    end
  end
end
