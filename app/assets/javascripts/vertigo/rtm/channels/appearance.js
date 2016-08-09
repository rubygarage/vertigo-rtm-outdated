namespace('Vertigo.Rtm.Channel.AppearanceChannel');

Vertigo.Rtm.Channel.AppearanceChannel = (function () {
  function AppearanceChannel() {
    Vertigo.Rtm.actionCable.cable.subscriptions.create('Vertigo::Rtm::AppearanceChannel', {
      connected: function() {},
      disconnected: function() {},
      received: function() {}
    });
  }
});
