FactoryGirl.define do
  factory :vertigo_rtm_preference, class: 'Vertigo::Rtm::Preference' do
    highlight_words { Faker::Lorem.words.join(', ') }
    push_everything { [true, false].sample }
    muted { [true, false].sample }

    preferenceable { [create(:user), create(:vertigo_rtm_conversation)].sample }

    trait :user do
      association :preferenceable, factory: :user
    end

    trait :conversation do
      association :preferenceable, factory: :vertigo_rtm_conversation
    end
  end
end
