//= require jquery
//= require jquery_ujs
//= require_tree .
//= require vertigo/rtm/application

$(document).ready(function() {
  var client = new Vertigo.Rtm.Client();

  new Vertigo.Rtm.Channel.EventChannel();
});
