namespace('Vertigo.Rtm.Utils');

Vertigo.Rtm.Utils = (function() {
  return {
    createDispatcher: createDispatcher
  }

  function createDispatcher(eventPairs, callbacks) {
    return function(data) {
      var event = eventPairs[data.type];

      if(event) {
        // FIXME: data.resource.data
        callbacks[event].fire(data.resource.data);
      } else {
        console.log('Channels', 'unknown event type:', data.type);
      }
    }
  };
})();
