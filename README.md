# Vertigo::Rtm
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'vertigo-rtm'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install vertigo-rtm
```

## Style Guide

* [JSON API](http://jsonapi.org/)
* [Ruby](https://github.com/bbatsov/ruby-style-guide)
* [Rails](https://github.com/bbatsov/rails-style-guide)

## Resources

### User
```js
{
  "data": {
    "id": 1,
    "type": "users",
    "attributes": {
      "name": "jon.snow",
      "status": "online"
    }
    "links": {
      "self": "http://example.com/users/1",
    }
  }
}
```
The `status` field has the following available values: `online`, `away`, `dnd`.

### Preference (user & conversation  preferences)
```js
{
  "id": 1,
  "type": "preferences",
  "attributes": {
    "highlightWords": "hi, hello",
    "pushEverything": false,
    "muted": false,
    "userId": 1 or "conversationId": 1
  },
  "links": {
    "self": "http://example.com/preferences/1"
  }
}
```

### Channel
```js
{
  "data":{
    "id": 1,
    "type": "channels"
    "attributes": {
      "name": "general",
      "state": "unarchive",
      "creatorId": 1,
      "memberIds": [1, 2, 3],
      "membersCount": 3,
      "messagesCount": 100,
      "unreadCount": 20,
      "lastReadAt": "2016-07-18 16:26:36",
      "createdAt": "2016-07-18 16:26:36",
      "updatedAt": "2016-07-18 16:26:36"
    },
    "links": {
      "self": "http://example.com/channels/1"
    }
  }
}
```
The `state` field has the following available values: `unarchive`, `archive`.

### Group
```js
{
  "data":{
    "id": 1,
    "type": "groups",
    "attributes":{
      "name": "john.show-david-bowie",
      "state": "unarchive",
      "creatorId": 1,
      "memberIds": [1, 2],
      "membersCount": 2,
      "messagesCount": 20,
      "unreadCount": 0,
      "lastReadAt": "2016-07-18 16:26:36",
      "createdAt": "2016-07-18 16:26:36",
      "updatedAt": "2016-07-18 16:26:36"
    }
    "links": {
      "self": "http://example.com/groups/1"
    }
  }
}
```
The `state` field has the following available values: `unarchive`, `archive`.

### Attachment
```js
{
  "id": 1,
  "type": "attachments",
  "name": "file.png",
  "size": 12345,
  "contentType": "image/png",
  "creatorId": 1,
  "messageId": 1,
  "url": "http://...",
  "thumbnails": [
    "small": "http://...",
    "medium": "http://...",
    "large": "http://..."
  ],
  "createdAt": "2016-07-18 16:26:36",
  "updatedAt": "2016-07-18 16:26:36",
  "links": {
    "self": "http://example.com/attachments/1",
    "related": {
      ...
    }
  }
}
```

### Message
```js
{
  "id": 1,
  "type": "messages",
  "attributes": {
    "text": "Hello",
    "creatorId": 1,
    "conversationId": 2,
    "attachments": [Attachments Collection],
    "createdAt": "2016-07-18 16:26:36",
    "updatedAt": "2016-07-18 16:26:36"
  },
  "links": {
    "self": "http://example.com/messages/1",
    "related": {
      ...
    }
  }
}
```

## Endpoints

#### GET /users

+ Parameters
  + q: `snow` (string)
  + userIds: `[1, 2, 3]` (array)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: User (array)

####  PATCH/PUT /users/:id

+ Parameters
  + status: `dnd` (string)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: User (object)

+ WebSocket Response
  + Attributes
    + data: User (object)

#### GET /users/:id/preference

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Preference (object)

#### PATCH/PUT /users/:id/preference

+ Parameters
  + highlightWords: `hello` (string)
  + pushEverything: `false` (boolean)
  + muted: `false` (boolean)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Preference (object)

#### GET /conversations

+ HTTP Response 200 (application/json)
  + Attributes (object)
    + currentUser: User (object)
    + channels: Channel (array)
    + groups: Group (array)
    + users: User (array)

#### POST /channels

+ Parameters
  + name: `fun` (string)
  + memberIds: `[2, 3]` (array)

+ HTTP Response 201 (application/json)
  + Attributes
    + data: Channel (object)

+ WebSocket Response
  + Attributes
    + data: Channel (object)

#### GET /channels/:id

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Channel (object)

#### PATCH/PUT /channels/:id

+ Parameters
  + name: `new name` (string)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Channel (object)

+ WebSocket Response
  + Attributes
    + data: Channel (object)

#### DELETE /channels/:id

+ HTTP Response 204 (application/json)

+ WebSocket Response
  + Attributes
    + data: id (integer)

#### PATCH/PUT /channels/:id/leave

+ HTTP Response 200 (application/json)

+ WebSocket Response
  + Attributes
    + data: Channel (object)

#### PATCH/PUT /channels/:id/kick

+ Parameters
  + memberId: `1` (integer)

+ HTTP Response 200 (application/json)

+ WebSocket Response
  + Attributes
    + data: Channel (object)

#### PUT/PATCH /channels/:id/invite

+ Parameters
  + memberId: `1` (integer)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Channel (object)

#### POST /groups

+ Parameters
  + memberIds: `[2, 3]` (array)

+ HTTP Response 201 (application/json)
  + Attributes
    + data: Group (object)

+ WebSocket Response
  + Attributes
    + data: Group (object)

#### GET /groups/:id

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Group (object)

#### DELETE /groups/:id

+ HTTP Response 204 (application/json)

+ WebSocket Response
  + Attributes
    + id (integer)

#### GET /conversations/:conversation_id/preference

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Preference (object)

#### PATCH/PUT /conversations/:conversation_id/preference

+ Parameters
  + highlightWords: `hello` (string)
  + pushEverything: `false` (boolean)
  + muted: `false` (boolean)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Preference (object)

#### GET /conversations/:conversation_id/messages

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Message (array)

#### POST /conversations/:conversation_id/messages

+ Parameters
  + text: `hello` (string)
  + attachmentAttributes: `[]` (array)
    + file: `...` (file object)

+ HTTP Response 201 (application/json)
  + Attributes
    + data: Message (object)

+ WebSocket Response
  + Attributes
    + data: Message (object)

#### PATCH/PUT /conversations/:conversation_id/messages/:id

+ Parameters
  + text: `hello v2.0` (string)

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Message (object)

+ WebSocket Response
  + Attributes
    + data: Message (object)

#### DELETE /conversations/:conversation_id/messages/:id

+ HTTP Response 204 (application/json)

+ WebSocket Response
  + Attributes
    + id (integer)

#### GET /conversations/:conversation_id/attachments

+ HTTP Response 200 (application/json)
  + Attributes
    + data: Attachment (array)

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
