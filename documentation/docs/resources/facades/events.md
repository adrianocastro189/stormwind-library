# Events

The Events facade is an important class in the Stormwind Library, as it
is responsible for capturing all World of Warcraft events and forwarding
them to the library handlers.

Its motivation is to provide a more detailed and mapped event system to
the addons, which can listen to the library events instead of the World
of Warcraft events. This way, the library can provide events data with the
mapped models, in a more OOP way.

Some events in World of Warcraft are not entirely related to what really
happened in the game and require some processing to be useful, especially
when they need to work with flags, states, and other complex data. That
said, the Stormwind Library attempts to perform this processing and
broadcast its own events, with its own data.

Finally, another motivation behind this facade is to ease on addons
maintenance when Blizzard changes the game events, as the library will keep
broadcasting the same events, with the same data, unless those changes
result in something that can't be determined anymore.

## How to get the Events instance

The Events facade instance is available in the Stormwind Library instance
under the `events` property and it's already initialized when the library
is loaded.

```lua
local events = library.events
```

## How to listen to a Stormwind Library event

To listen to a Stormwind Library event, you should use the `listen` method
from the Events class. This method receives two parameters: the event name
and the callback to be called when the event is triggered.

```lua
library.events:listen('SOME_STORMWIND_LIBRARY_EVENT_NAME', function (param)
    print(param)
end)
```

### Available events

Stormwind Library event names have constants to avoid typos and to make it
easier to track their usage.

Every handler should register one or more event names to the main Events
class, which means the facade instance can be inspected to check which
events can be watched.

These are the available Stormwind Library events to be listened by addons
with the `Events:listen(event, callback)` method. It's advisable to use
the constants defined in the Stormwind Library to avoid typos and to make
the code more readable.

#### `PLAYER_LEVEL_UP`

* **Constant:** `library.events.EVENT_NAME_PLAYER_LEVEL_UP`
* **Payload:** an integer with the **new** player level
* **Description:** This event is the same as the World of Warcraft event
called `PLAYER_LEVEL_UP`, but with fewer data.

#### `PLAYER_LOGIN`

* **Constant:** `library.events.EVENT_NAME_PLAYER_LOGIN`
* **Payload:** No data is sent with this event
* **Description:** This event is the same as the World of Warcraft event
called `PLAYER_LOGIN`.

#### `PLAYER_TARGET`

* **Constant:** `library.events.EVENT_NAME_PLAYER_TARGET`
* **Payload:** No data is sent with this event
* **Description:** Triggered when a player targets a unit but had no
target before.

#### `PLAYER_TARGET_CHANGED`

* **Constant:** `library.events.EVENT_NAME_PLAYER_TARGET_CHANGED`
* **Payload:** No data is sent with this event
* **Description:** Triggered when a player changes its current target.

#### `PLAYER_TARGET_CLEAR`

* **Constant:** `library.events.EVENT_NAME_PLAYER_TARGET_CLEAR`
* **Payload:** No data is sent with this event
* **Description:** Triggered when a player clears the target.

#### `TOOLTIP_ITEM_SHOWN`

* **Constant:** (not available yet)
* **Payload:** [Item](../models/item)
* **Description:** Triggered when an item tooltip is shown.

#### `TOOLTIP_UNIT_SHOWN`

* **Constant:** (not available yet)
* **Payload:** No data is sent with this event
* **Description:** Triggered when a unit tooltip is shown.

## How does this facade works

This section is intended to explain how the Events facade works, and how
new events can be added to the library. It's focused on developers who
want to improve the library by adding new events or modifying existing
ones.

### The Events Frame

Once instantiated, the Events class creates a frame that will start to
listen to all World of Warcraft events. A script is attached to this
frame's `OnEvent` event.

In the Stormwind Library context, this frame will be responsible for
capturing all World of Warcraft events and forwarding them to the library
handlers.

### The main library callback method

The `Events:handleOriginal()` method is called whenever a World of Warcraft
event is triggered. It will check if there is a callback registered for
that event and, if so, it will call it.

This is where the event is redirected to the library handlers.

### The library handlers

The library handlers are the callbacks registered to handle World of
Warcraft events.

They're created in the `src/Facades/EventHandlers` folder and will
basically use an anonymous function or create a callback function, which
most of the times will be part of the `Events` class and call the
`Events:listenOriginal()` method, passing the **World of Warcraft event
name** and this callback.

:::note The listener suffix

When attaching a method to the Events class, use the `listener` suffix as
a convention to indicate that the method is a listener.

:::

The callback implementation performs all the necessary logic to handle the
event, like setting flags, states, etc, and then calls the `Events:notify()`
method passing the **Stormwind Library event name** and the parameters to be
forwarded to the library listeners.

:::tip Handling event states

Although handlers are free to manage states as they want, there's a
property in `Events` called `eventStates` that can be used to store simple
flags and other properties to centralize the state management and also
allow handlers to communicate with each other if necessary.

:::