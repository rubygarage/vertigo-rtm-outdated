//= require action_cable
//= require_tree ./utils
//= require_self
//= require_tree ./channels

namespace('Vertigo.Rtm.Client');

Vertigo.Rtm.createConsumer = function(options) {
  Vertigo.Rtm.actionCable || (Vertigo.Rtm.actionCable = {});

  Vertigo.Rtm.actionCable.cable = ActionCable.createConsumer(options);

  return;
};

Vertigo.Rtm.Client = (function () {
  function Client (options) {
    Vertigo.Rtm.createConsumer(options);
  };

  return Client;
})();
