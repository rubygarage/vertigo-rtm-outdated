FactoryGirl.define do
  factory :vertigo_rtm_channel, class: 'Vertigo::Rtm::Channel' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Channel' }
    messages_count { 0 }
    members_count { 0 }

    association :creator, factory: :user

    trait :unarchived do
      state { Vertigo::Rtm::Channel.states[:unarchived] }
    end

    trait :archived do
      state { Vertigo::Rtm::Channel.states[:archived] }
    end
  end
end
