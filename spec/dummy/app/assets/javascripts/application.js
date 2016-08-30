//= require jquery
//= require jquery_ujs
//= require_tree .
//= require vertigo/rtm/application

'use strict';

$(run);

function run() {
  var app = angular.module('Dummy', []);

  app.factory('vertigoRtmClient', [function() {
    return new Vertigo.Rtm.Client('/vertigo-rtm');
  }]);

  app.component('startContainer', {
    templateUrl: 'templates/start_container.html',
    controller: ['vertigoRtmClient', '$scope', function(vertigoRtmClient, $scope) {
      var controller = this;

      controller.currentUser = null;
      controller.channels = [];
      controller.groups = [];

      controller.selectedConversation = null;

      vertigoRtmClient.start().then(function(data) {
        return $scope.$apply(function() {
          controller.currentUser = data.currentUser;
          controller.channels = data.channels;
          controller.groups = data.groups;
          controller.conversations = [data.channels[0], data.groups[0]];
          controller.users = data.users;
        });
      });

      controller.selectConversation = selectConversation;

      function selectConversation(id) {
        return controller.selectedConversation = controller.conversations.filter(function(a) {
          return a.id == id;
        })[0];
      }
      // controller.createChannel = createChannel;

      // function createChannel(channel) {
      //   return vertigoRtmClient.channels.create(channel);
      // }

      // function selectConversation(id) {
      //   return controller.selectedConversation = controller.conversations.filter(function(a) {
      //     return a.id == id;
      //   })[0];
      // }

      // vertigoRtmClient.channels.on('created', function(data) {
      //   return $scope.$apply(function() {
      //     return controller.conversations.push(data);
      //   });
      // });
    }]
  });

  app.component('sidebarHeader', {
    templateUrl: 'templates/sidebar_header.html',
    bindings: {
      user: '<'
    },
    controller: [function() {
      var controller = this;
    }]
  });

  app.component('channelList', {
    templateUrl: 'templates/channel_list.html',
    bindings: {
      collection: '<',
      onConversationClick: '<',
      selectedConversation: '<'
    },
    controller: [function() {
      var controller = this;

      controller.isSelectedConversation = isSelectedConversation;

      function isSelectedConversation(conversation) {
        return controller.selectedConversation === conversation;
      }
    }]
  });

  app.component('channelDetails', {
    templateUrl: 'templates/channel_details.html',
    bindings: {
      conversation: '<',
    },
    controller: [function() {
      var controller = this;
    }]
  });

  app.component('groupList', {
    templateUrl: 'templates/group_list.html',
    bindings: {
      collection: '<',
      onConversationClick: '<',
      selectedConversation: '<'
    },
    controller: [function() {
      var controller = this;

      controller.isSelectedConversation = isSelectedConversation;

      function isSelectedConversation(conversation) {
        return controller.selectedConversation === conversation;
      }
    }]
  });

  // app.component('channelForm', {
  //   templateUrl: 'templates/channel_form.html',
  //   bindings: {
  //     onSubmit: '='
  //   },
  //   controller: [function() {
  //     this.channel = {};
  //   }]
  // });

  // app.component('conversationList', {
  //   templateUrl: 'templates/conversation_list.html',
  //   bindings: {
  //     conversations: '<',
  //     selectedConversation: '<',
  //     onConversationClick: '<',
  //     type: '<'
  //   },
  //   controller: [function() {
  //     var controller = this;

  //     controller.isSelectedConversation = isSelectedConversation;

  //     function isSelectedConversation(conversation) {
  //       return controller.selectedConversation === conversation;
  //     }
  //   }]
  // });

  app.component('messageList', {
    templateUrl: 'templates/message_list.html',
    bindings: {
      conversation: '<',
      users: '<'
    },
    controller: ['vertigoRtmClient', '$scope', function(vertigoRtmClient, $scope) {
      var controller = this;

      controller.messages = [];

      controller.msgOwnerName = function(user_id) {
        return controller.users.filter(function(a) {
          return a.id == user_id;
        })[0].attributes.name;
      }

      controller.$onChanges = function() {
        return vertigoRtmClient.messages.all({
          conversationId: controller.conversation.id
        }).then(function(data) {
          return $scope.$apply(function() {
            return controller.messages = data;
          });
        });
      };
    }]
  });
}

// // RESTful API

// client.start({}, (err, data));                // Starts a Real Time Messaging session.

// client.channels.create({}, (err, data));      // Creates a channel.
// client.channels.info({}, (err, data));        // Gets information about a channel.
// client.channels.rename({}, (err, data));      // Renames a channel.
// client.channels.archive({}, (err, data));     // Archives a channel.
// client.channels.unarchive({}, (err, data));   // Unarchives a channel.
// client.channels.history({}, (err, data));     // Fetches history of messages and events from a channel.
// client.channels.invite({}, (err, data));      // Invites a user to a channel.
// client.channels.kick({}, (err, data));        // Removes a user from a channel.
// client.channels.leave({}, (err, data));       // Leaves a channel.

// client.messages.create({}, (err, data));      // Sends a message to a conversation.
// client.messages.update({}, (err, data));      // Updates a message.
// client.messages.delete({}, (err, data));      // Deletes a message.

// client.groups.create({}, (err, data));        // Creates a channel.
// client.groups.history({}, (err, data));       // Fetches history of messages and events from a channel.
// client.groups.info({}, (err, data));          // Gets information about a private channel.

// client.users.offline(..)
// client.users.away(..)
// client.users.dnd(..)
// client.users.online(..)

// // WebSocket API

// client.channels.on('created', function() {

// });

// // Events:
// // 1. channel_archive
// // 2. channel_created
// // 3. channel_joined
// // 4. channel_left
// // 5. channel_rename
// // 6. channel_unarchive

// // 7. group_created

// // 8. message
