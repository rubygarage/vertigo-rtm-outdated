FactoryGirl.define do
  factory :vertigo_rtm_group, class: 'Vertigo::Rtm::Group' do
    name { Faker::Team.name }
    type { 'Vertigo::Rtm::Group' }
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
