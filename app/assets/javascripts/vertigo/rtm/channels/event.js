namespace('Vertigo.Rtm.Channel.EventChannel');

EventChannel = Vertigo.Rtm._actionCable().cable.subscriptions.create('Vertigo::Rtm::EventChannel', {
  connected: function() {},
  disconnected: function() {},
  received: function() {}
});

Vertigo.Rtm.Channel.EventChannel = EventChannel;
