//= require action_cable
//= require_tree ./utils
//= require_self

namespace('Vertigo.Rtm.createConsumer');

Vertigo.Rtm.createConsumer = function(options) {
  Vertigo.Rtm.actionCable = Vertigo.Rtm.actionCable || {};
  Vertigo.Rtm.actionCable.cable = ActionCable.createConsumer(options);
  return Vertigo.Rtm.actionCable.cable;
};
