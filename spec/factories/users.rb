FactoryGirl.define do
  factory :user, class: '::User' do
    name { Faker::Internet.user_name }
    email { Faker::Internet.email }

    trait :offline do
      vertigo_rtm_status Vertigo::Rtm.user_class.vertigo_rtm_statuses[:offline]
    end

    trait :away do
      vertigo_rtm_status Vertigo::Rtm.user_class.vertigo_rtm_statuses[:away]
    end

    trait :online do
      vertigo_rtm_status Vertigo::Rtm.user_class.vertigo_rtm_statuses[:online]
    end

    trait :dnd do
      vertigo_rtm_status Vertigo::Rtm.user_class.vertigo_rtm_statuses[:dnd]
    end
  end
end
