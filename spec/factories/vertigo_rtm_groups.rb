FactoryGirl.define do
  factory :vertigo_rtm_group, class: 'Vertigo::Rtm::Group' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Group' }
    messages_count { 0 }
    members_count { 0 }

    association :creator, factory: :user

    trait :unarchive do
      state Vertigo::Rtm::Group.states[:unarchive]
    end

    trait :archive do
      state Vertigo::Rtm::Group.states[:archive]
    end
  end
end
