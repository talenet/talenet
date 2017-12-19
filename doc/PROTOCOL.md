# Communication and data storage protocol for tale:net

## General

We use [Secure Scuttlebutt](https://ssbc.github.io/secure-scuttlebutt/) and [Scuttlebot](https://scuttlebot.io/) for
for peer-to-peer communication and data storage.

## Messages

### General structure of a message

Every message has an `author` which holds her / his public key. The `timestamp` specifies the time (on the author's
machine) the message been created.

The `content` field is an object holding the message specific payload. Additionally there are for each tale:net message
always the field `type` and `talenet-version`:

* `type` specifies what type of message is being posted. tale:net specific messages have a type prefixed with `talenet-`.
  For tale:net specific messages the types are also structured hierarchically.
* `talenet-version` specifies the protocol version of tale:net. May be used in the future to handle messages with an old
  version differently or to detect messages which are not supported by an old client.

```javascript
{
  author: '<KEY>',
  timestamp: 1508843962,
  
  // ...
  
  content: {
    type: '<TYPE>',
    'talenet-version': 1
    
    // ...
  }
}
```

For additional fields please refer to the
[Secure Scuttlebutt documentation](https://ssbc.github.io/secure-scuttlebutt/).

The following definitions will only specify the message specific fields of `content` and omit the `talenet-version`.

### Skill related messages

#### Skill creation

```javascript
{
  type: 'talenet-skill-create',
  name: '<STRING>'
}
```

* `name`: Name of the skill.

### Idea related messages

#### Idea creation

```javascript
{
  type: 'talenet-idea-create',
  originalIdeaKey: '<KEY>'
}
```

* `originalIdeaKey` *(optional)*: When copying / forking an idea this key specifies the idea being forked / copied. 

#### Idea update

```javascript
{
  type: 'talenet-idea-update',
  ideaKey: '<KEY>',

  title: '<STRING>',
  description: '<MD_STRING>',
  status: '<STATUS_ENUM>'
}
```

* `ideaKey`: Key of the idea being updated.

Any combination of the following fields may be used:

* `title`: New title of the idea.
* `description`: New description of the idea. May use markdown syntax.
* `status`: New status of the idea. (TODO: Define status values.) 

#### Idea: Skill assignment

```javascript
{
  type: 'talenet-idea-skill_assignment',
  ideaKey: '<KEY>',
 
  skillKey: '<KEY>',
  action: '[assign|unassign]'
}
```

* `ideaKey`: Key of the idea to assign / unassign the skill to / from.
* `skillKey`: Key of the skill to assign / unassign.
* `action`: Whether to assign / unassign the skill to / from the idea.

#### Idea: Hat status

```javascript
{
  type: 'talenet-idea-hat',
  ideaKey: '<KEY>',

  action: '[take|discard]'
}
```

* `ideaKey`: Key of the idea to take or discard the hat for.
* `action`: Whether to take or discard the hat. 

#### Idea: Association

```javascript
{
  type: 'talenet-idea-association',
  ideaKey: '<KEY>',

  action: '[associate|disassociate]'
}
```

* `ideaKey`: Key of the idea to associate with or to disassociate from.
* `action`: Whether to associate with or to disassociate from the idea.

#### Idea: Comment

```javascript
{
  type: 'talenet-idea-comment',
  ideaKey: '<KEY>',
  
  text: '<MD_STRING>'
}
```

* `ideaKey`: Key of the idea to comment on.
* `text`: Text of the comment. May use markdown syntax.

#### Idea: Comment reply

```javascript
{
  type: 'talenet-idea-comment_reply',
  ideaKey: '<KEY>',
  commentKey: '<KEY>',
  
  text: '<MD_STRING>'
}
```

* `ideaKey`: Key of the idea the comment which to reply to is associated with.
* `commentKey`: Key of the comment to reply to.
* `text`: Text of the reply. May use markdown syntax.

### Indentity related messages

In general we reuse Secure Scuttlebutt's about mechanism for identity data like
name, image, etc. For functionality going beyond this scope we have defined the
following messages:

#### Identity: Skill assignment

```javascript
{
  type: 'talenet-identity-skill_assignment',

  skillKey: '<KEY>',
  action: '[assign|unassign]'
}
```

The skill will be assigned to / unassigned from the identity of the message's author.

* `skillKey`: Key of the skill to assign / unassign.
* `action`: Whether to assign / unassign the skill to / from the idea.
