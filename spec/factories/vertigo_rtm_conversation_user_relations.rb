FactoryGirl.define do
  factory :vertigo_rtm_conversation_user_relation, class: 'Vertigo::Rtm::ConversationUserRelation' do
    last_read_at { Time.zone.now }

    association :user, factory: :user
    association :conversation, factory: :vertigo_rtm_conversation
  end
end
