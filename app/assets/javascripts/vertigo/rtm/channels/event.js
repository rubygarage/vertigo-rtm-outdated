namespace('Vertigo.Rtm.Channel.EventChannel');

Vertigo.Rtm.Channel.EventChannel = (function () {
  function EventChannel() {
    Vertigo.Rtm.actionCable.cable.subscriptions.create('Vertigo::Rtm::EventChannel', {
      connected: function() {},
      disconnected: function() {},
      received: function() {}
    });
  }
});
