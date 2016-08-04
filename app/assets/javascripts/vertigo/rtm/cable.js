//= require action_cable
//= require_tree ./utils
//= require_self
//= require_tree ./channels

namespace('Vertigo.Rtm.Client');

Vertigo.Rtm._actionCable = function() {
  this.instance = null;

  var getInstance = function () {
    if (!this.instance) {
      this.instance = createInstance();
    }

    return this.instance;
  }

  var createInstance = function () {
    this.instance || (this.instance = {});
    this.instance.cable = ActionCable.createConsumer();

    return this.instance;
  }

  return getInstance();
};
