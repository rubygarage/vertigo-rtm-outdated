namespace('Vertigo.Rtm.Conversations');

Vertigo.Rtm.Conversations = (function() {
  function Conversations(channel, restClient) {
    this.channel = channel;
    this.restClient = restClient;
  }

  Conversations.prototype.all = function() {
    return this.restClient.getConversations();
  };

  return Conversations;
})();
