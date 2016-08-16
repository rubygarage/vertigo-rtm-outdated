namespace('Vertigo.Rtm.EventChannel');

Vertigo.Rtm.EventChannel = (function () {
  function EventChannel(cable) {
    this.callbacks = {
      connected: $.Callbacks(),
      disconnected: $.Callbacks(),
      received: $.Callbacks()
    };

    cable.subscriptions.create(
      'Vertigo::Rtm::EventChannel', {
      connected: this.callbacks['connected'].fire,
      disconnected: this.callbacks['disconnected'].fire,
      received: this.callbacks['received'].fire
    });
  }

  EventChannel.prototype.on = function(event, callback) {
    this.callbacks[event].add(callback);
  };

  return EventChannel;
})();
