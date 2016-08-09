namespace('Vertigo.Rtm.Channel.ConversationChannel');

ConversationChannel = Vertigo.Rtm._actionCable().cable.subscriptions.create('Vertigo::Rtm::ConversationChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function() {}
});

Vertigo.Rtm.Channel.ConversationChannel = ConversationChannel;
