namespace('Vertigo.Rtm.Channel.EventChannel');

Vertigo.Rtm.Channel.EventChannel = (function () {
  function EventChannel() {
    Vertigo.Rtm.actionCable.cable.subscriptions.create('Vertigo::Rtm::EventChannel', {
      connected: function() {console.log('connected');},
      disconnected: function() {console.log('disconnected');},
      received: function(data) {console.log('received'); console.log(data);}
    });
  }

  return EventChannel;
})();
