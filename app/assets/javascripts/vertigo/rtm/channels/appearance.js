namespace('Vertigo.Rtm.Channel.AppearanceChannel');

AppearanceChannel = Vertigo.Rtm._actionCable().cable.subscriptions.create('Vertigo::Rtm::AppearanceChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function() {}
});

Vertigo.Rtm.Channel.AppearanceChannel = AppearanceChannel;
