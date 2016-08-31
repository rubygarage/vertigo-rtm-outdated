namespace('Vertigo.Rtm.Client');

Vertigo.Rtm.Client = (function () {
  function Client(mountPath, options) {
    var cable = Vertigo.Rtm.createConsumer(options);
    var eventChannel = new Vertigo.Rtm.EventChannel(cable);
    var restClient = new Vertigo.Rtm.RestClient(mountPath);

    this.conversations = new Vertigo.Rtm.Conversations(eventChannel, restClient);
    this.channels = new Vertigo.Rtm.Channels(eventChannel, restClient);
    this.messages = new Vertigo.Rtm.Messages(eventChannel, restClient);

    this.start = function() {
      return restClient.getConversations();
    };

    eventChannel.on('connected', function() { console.log('connected') });
    eventChannel.on('disconnected', function() { console.log('disconnected') });
    eventChannel.on('received', function(data) { console.log('received', data) });
  };

  return Client;
})();
