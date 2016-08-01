FactoryGirl.define do
  factory :vertigo_rtm_channel, class: 'Vertigo::Rtm::Channel' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Channel' }
    messages_count { 0 }
    members_count { 0 }

    association :creator, factory: :user

    trait :unarchive do
      state { Vertigo::Rtm::Channel.states[:unarchive] }
    end

    trait :archive do
      state { Vertigo::Rtm::Channel.states[:archive] }
    end
  end
end
