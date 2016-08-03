FactoryGirl.define do
  factory :vertigo_rtm_membership, class: 'Vertigo::Rtm::Membership' do
    last_read_at { Time.zone.now }

    association :user, factory: :user
    association :conversation, factory: :vertigo_rtm_conversation
  end
end
