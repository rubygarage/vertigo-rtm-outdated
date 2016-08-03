FactoryGirl.define do
  factory :vertigo_rtm_preference, class: 'Vertigo::Rtm::Preference' do
    highlight_words { Faker::Lorem.words.join(', ') }
    notify_on_mention { [true, false].sample }
    notify_on_message { [true, false].sample }
    muted { [true, false].sample }

    preferenceable { [create(:user), create(:vertigo_rtm_membership)].sample }

    trait :for_user do
      association :preferenceable, factory: :user
    end

    trait :for_membership do
      association :preferenceable, factory: :vertigo_rtm_membership
    end
  end
end
