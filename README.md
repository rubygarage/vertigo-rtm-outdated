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

### File
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
  "attachments": [Files Collection],
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

GET rtm/users

+ Parameters
    + q: `snow` (string)
    + userIds: `[1, 2, 3]` (array)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Users Collection]
  }
  ```

PATCH/PUT rtm/users/:id

+ Parameters
  + status: `dnd` (string)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [User]
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [User]
  }
  ```

GET rtm/users/:id/preference

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Preference]
  }
  ```

PATCH/PUT rtm/users/:id/preference

+ Parameters
  + highlightWords: `hello` (string)
  + pushEverything: `false` (boolean)
  + muted: `false` (boolean)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Preference]
  }
  ```

GET rtm/conversations

+ HTTP Response

  ```js
  {
    "ok": true,
    "currentUser": [User],
    "channels": [Channels Collection],
    "groups": [Groups Collection],
    "users": [Users Collection]
  }
  ```

POST rtm/channels

+ Parameters
  + name: `fun` (string)
  + memberIds: `[2, 3]` (array)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Channel]
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [Channel]
  }
  ```

GET rtm/channels/:id

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Channel]
  }
  ```

PATCH/PUT rtm/channels/:id

+ Parameters
  + name: `new name` (string)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Channel]
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [Channel]
  }
  ```

DELETE rtm/channels/:id

+ HTTP Response

  ```js
  {
    "ok": true
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": {
      "id": 1
    }
  }
  ```

PATCH/PUT rtm/channels/:id/leave

+ HTTP Response

  ```js
  {
    "ok": true
  }
  ```

+ WebSocket Response

  ```js
  {
    "ok": true,
    "data": [Channel]
  }
  ```

PATCH/PUT rtm/channels/:id/kick

+ HTTP Response

  ```js
  {
    "ok": true
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [Channel]
  }
  ```

PUT/PATCH rtm/channels/:id/invite

+ Parameters
  + userId: `1` (integer)

+ HTTP Response

  ```js
  {
    "ok": true
  }
  ```

  or

  ```js
  {
    "data": [Channel]
  }
  ```

POST rtm/groups

+ Parameters
  + memberIds: `[2, 3]` (array)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Group]
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [Group]
  }
  ```

GET rtm/groups/:id

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Group]
  }
  ```

DELETE rtm/groups/:id

  + HTTP Response

  ```js
  {
    "ok": true
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": {
      "id": 1
    }
  }
  ```

GET rtm/conversations/:conversation_id/preference

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Preference]
  }
  ```

PATCH/PUT rtm/conversations/:conversation_id/preference

+ Parameters
  + highlightWords: `hello` (string)
  + pushEverything: `false` (boolean)
  + muted: `false` (boolean)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Preference]
  }
  ```

GET rtm/conversations/:conversation_id/messages

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Messages Collection],
    "meta": [Meta]
  }
  ```

POST rtm/conversations/:conversation_id/messages

+ Parameters
  + text: `hello` (string)
  + attachmentAttributes: `[]` (array)
    + file: `...` (file object)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Message]
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [Message]
  }
  ```

PATCH/PUT rtm/conversations/:conversation_id/messages/:id

+ Parameters
  + text: `hello v2.0` (string)

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Message]
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": [Message]
  }
  ```

DELETE rtm/conversations/:conversation_id/messages/:id

+ HTTP Response

  ```js
  {
    "ok": true
  }
  ```

+ WebSocket Response

  ```js
  {
    "data": {
      "id": 1
    }
  }
  ```

GET rtm/conversations/:conversation_id/files

+ HTTP Response

  ```js
  {
    "ok": true,
    "data": [Files Collection],
    "meta": [Meta]
  }
  ```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
