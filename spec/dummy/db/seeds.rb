user = User.find_or_create_by(name: 'seed_user')

Vertigo::Rtm::Message.delete_all
Vertigo::Rtm::Conversation.delete_all

conversation =
  Vertigo::Rtm::Conversation
  .find_or_create_by!(name: 'seed_channel', creator: user, type: 'Vertigo::Rtm::Channel')

conversation_2 =
  Vertigo::Rtm::Conversation
  .find_or_create_by!(name: 'seed_group', creator: user, type: 'Vertigo::Rtm::Group')

messages = 5.times.map do |i|
  { text: "Hello world #{i + 1}", creator: user }
end

conversation.messages.delete_all
conversation.messages.create!(messages)
