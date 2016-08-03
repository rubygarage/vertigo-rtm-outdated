FactoryGirl.define do
  factory :vertigo_rtm_conversation, class: 'Vertigo::Rtm::Conversation' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Conversation' }
    messages_count { 0 }
    members_count { 0 }

    association :creator, factory: :user

    trait :unarchive do
      state Vertigo::Rtm::Conversation.states[:unarchive]
    end

    trait :archive do
      state Vertigo::Rtm::Conversation.states[:archive]
    end
  end
end
