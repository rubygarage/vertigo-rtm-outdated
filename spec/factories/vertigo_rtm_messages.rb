FactoryGirl.define do
  factory :vertigo_rtm_message, class: 'Vertigo::Rtm::Message' do
    text { Faker::Lorem.sentence }
    association :creator, factory: :user
    association :conversation, factory: :vertigo_rtm_conversation
  end
end
