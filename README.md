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

* [RESTful API](http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api)

## Resources

### User
```js
{
  "id": 1,
  "name": "jon.snow",
  "status": "online"
}
```
The `status` field has the following available values: `online`, `away`, `dnd`.

### Preference
```js
{
  "highlightWords": "hi, hello",
  "pushEverything": false,
  "muted": false
}
```

### Channel
```js
{
  "id": 1,
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
}
```
The `state` field has the following available values: `unarchive`, `archive`.

### Group
```js
{
  "id": 1,
  "name": "secretplans",
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
```
The `state` field has the following available values: `unarchive`, `archive`.

### Attachment
```js
{
  "id": 1,
  "name": "file.png",
  "size": 12345,
  "contentType": "image/png",
  "creatorId": 1,
  "url": "http://...",
  "thumbnails": [
    "small": "http://...",
    "medium": "http://...",
    "large": "http://..."
  ],
  "createdAt": "2016-07-18 16:26:36",
  "updatedAt": "2016-07-18 16:26:36"
}
```

### Message
```js
{
  "text": "Hello",
  "creatorId": 1,
  "attachments": [Attachment],
  "createdAt": "2016-07-18 16:26:36",
  "updatedAt": "2016-07-18 16:26:36"
}
```

### Meta
```js
{
  "totalCount": 50,
  "perPage": 10
}
```
The default value for `perPage` is 100.


## Endpoints

#### GET rtm/users

+ Parameters
  + q: `snow` (string)
  + userIds: `[1, 2, 3]` (array)

+ HTTP Response 200 (application/json)
  + Attributes (object)
    + data: User (array)
    + meta: Meta (object)

####  PATCH/PUT rtm/users/:id

+ Parameters
  + status: `dnd` (string)

+ HTTP Response 200 (application/json)
  + Attributes
    + User (object)

+ WebSocket Response
  + Attributes
    + User (object)

#### GET rtm/users/:id/preference

+ HTTP Response 200 (application/json)
  + Attributes
    + Preference (object)

#### PATCH/PUT rtm/users/:id/preference

+ Parameters
  + highlightWords: `hello` (string)
  + pushEverything: `false` (boolean)
  + muted: `false` (boolean)

+ HTTP Response 200 (application/json)
  + Attributes
    + Preference (object)

#### GET rtm/conversations

+ HTTP Response 200 (application/json)
  + Attributes (object)
    + currentUser: User (object)
    + channels: Channel (array)
    + groups: Group (array)
    + users: User (array)

#### POST rtm/channels

+ Parameters
  + name: `fun` (string)
  + memberIds: `[2, 3]` (array)

+ HTTP Response 201 (application/json)
  + Attributes
    + Channel (object)

+ WebSocket Response
  + Attributes
    + Channel (object)

#### GET rtm/channels/:id

+ HTTP Response 200 (application/json)
  + Attributes
    + Channel (object)

#### PATCH/PUT rtm/channels/:id

+ Parameters
  + name: `new name` (string)

+ HTTP Response 200 (application/json)
  + Attributes
    + Channel (object)

+ WebSocket Response
  + Attributes
    + Channel (object)

#### DELETE rtm/channels/:id

+ HTTP Response 204 (application/json)

+ WebSocket Response
  + Attributes (object)
    + id (integer)

#### PATCH/PUT rtm/channels/:id/leave

+ HTTP Response 200 (application/json)

+ WebSocket Response
  + Attributes
    + Channel (object)

#### PATCH/PUT rtm/channels/:id/kick

+ Parameters
  + memberId: `1` (integer)

+ HTTP Response 200 (application/json)
  + Attributes
    + Channel (object)

+ WebSocket Response
  + Attributes
    + Channel (object)

#### PUT/PATCH rtm/channels/:id/invite

+ Parameters
  + memberId: `1` (integer)

+ HTTP Response 200 (application/json)
  + Attributes
    + Channel (object)

#### POST rtm/groups

+ Parameters
  + memberIds: `[2, 3]` (array)

+ HTTP Response 201 (application/json)
  + Attributes
    + Group (object)

+ WebSocket Response
  + Attributes
    + Group (object)

#### GET rtm/groups/:id

+ HTTP Response 200 (application/json)
  + Attributes
    + Group (object)

#### DELETE rtm/groups/:id

+ HTTP Response 204 (application/json)

+ WebSocket Response
  + Attributes (object)
    + id (integer)

#### GET rtm/conversations/:conversation_id/preference

+ HTTP Response 200 (application/json)
  + Attributes
    + Preference (object)

#### PATCH/PUT rtm/conversations/:conversation_id/preference

+ Parameters
  + highlightWords: `hello` (string)
  + pushEverything: `false` (boolean)
  + muted: `false` (boolean)

+ HTTP Response 200 (application/json)
  + Attributes
    + Preference (object)

#### GET rtm/conversations/:conversation_id/messages

+ HTTP Response 200 (application/json)
  + Attributes (object)
    + data: Message (array)
    + meta: Meta (object)

#### POST rtm/conversations/:conversation_id/messages

+ Parameters
  + text: `hello` (string)
  + attachmentAttributes: `[]` (array)
    + file: `...` (file object)

+ HTTP Response 201 (application/json)
  + Attributes
    + Message (object)

+ WebSocket Response
  + Attributes
    + Message (object)

#### PATCH/PUT rtm/conversations/:conversation_id/messages/:id

+ Parameters
  + text: `hello v2.0` (string)

+ HTTP Response 200 (application/json)
  + Attributes
    + Message (object)

+ WebSocket Response
  + Attributes
    + Message (object)

#### DELETE rtm/conversations/:conversation_id/messages/:id

+ HTTP Response 204 (application/json)

+ WebSocket Response
  + Attributes
    + id (integer)

#### GET rtm/conversations/:conversation_id/attachments

+ HTTP Response 200 (application/json)
  + Attributes (object)
    + data: Attachment (array)
    + meta: Meta (object)

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
