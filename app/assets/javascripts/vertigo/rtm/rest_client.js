namespace('Vertigo.Rtm.RestClient');

Vertigo.Rtm.RestClient = (function() {
  function RestClient(mountPath) {
    this.mountPath = mountPath;
  }

  RestClient.prototype.getConversations = function() {
    return $.get(this.mountPath + '/conversations').then(getData);
  };

  RestClient.prototype.getConversationMessages = function(id) {
    return $.get(this.mountPath + '/conversations/' + id + '/messages').then(getData);
  };

  RestClient.prototype.createChannel = function(channel) {
    return $.post(this.mountPath + '/channels', { channel: channel }).then(getData);
  };

  function getData(res) {
    return res.data;
  }

  return RestClient;
})();
