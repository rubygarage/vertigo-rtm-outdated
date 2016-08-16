namespace('Vertigo.Rtm.Channels');

Vertigo.Rtm.Channels = (function() {
  function Channels(channel, restClient) {
    this.channel = channel;
    this.restClient = restClient;
    this.callbacks = {
      created: $.Callbacks()
    }

    var dispatcher = Vertigo.Rtm.Utils.createDispatcher({
      channel_created: 'created'
    }, this.callbacks);

    this.channel.on('received', dispatcher);
  }

  Channels.prototype.on = function(event, cb) {
    return this.callbacks[event].add(cb);
  };

  Channels.prototype.create = function(channel) {
    return this.restClient.createChannel(channel);
  };

  return Channels;
})();
