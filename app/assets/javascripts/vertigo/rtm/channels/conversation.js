namespace('Vertigo.Rtm.Channel.ConversationChannel');

Vertigo.Rtm.Channel.ConversationChannel = (function () {
  function ConversationChannel() {
    Vertigo.Rtm.actionCable.cable.subscriptions.create('Vertigo::Rtm::ConversationChannel', {
      connected: function() {},
      disconnected: function() {},
      received: function() {}
    });
  }

  return ConversationChannel;
})();
