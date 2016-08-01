FactoryGirl.define do
  factory :vertigo_rtm_channel, class: 'Vertigo::Rtm::Channel' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Channel' }
    status { [0, 1].sample }
    messages_count { 0 }
    members_count { 0 }

    association :creator, factory: :user

    trait :unarchive do
      status { 0 }
    end

    trait :archive do
      status { 1 }
    end
  end
end
