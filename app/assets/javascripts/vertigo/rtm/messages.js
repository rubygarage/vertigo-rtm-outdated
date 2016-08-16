namespace('Vertigo.Rtm.Messages');

Vertigo.Rtm.Messages = (function() {
  function Messages(channel, restClient) {
    this.channel = channel;
    this.restClient = restClient;
  }

  Messages.prototype.all = function(opts) {
    return this.restClient.getConversationMessages(opts.conversationId);
  };

  return Messages;
})();
