# Player

The Player class is a model that maps player information.

Just like any other model, it's used to standardize the way addons interact 
with data related to players.

Its first version, introduced in the library version 1.2.0 includes only a few
basic properties like `guid`, `name` and `realm`, but this model will grow 
over time as new expansions are released and new features are implemented in 
the library.

For a more detailed explanation of the Player model and its available methods 
and properties, please refer to the library
[technical documentation](pathname:///lua-docs/classes/Models.Player.html).

## Getting the current player instance

The current player instance can be retrieved using a "static" method of the
Player class, which also takes care of creating the instance and setting its
properties using the World of Warcraft API.

```lua
local player = library:getClass('Player').getCurrentPlayer()
```

Note that the example above is not not calling `:getCurr...` but
`.getCurr...` because this method is associated with the class itself, not 
with an instance of the class.

For convenience, once the library is loaded, the current player instance is
automatically created and stored in a property called `currentPlayer`.

```lua
local player = library.currentPlayer
```

## Player in combat status

From version 1.7.0, the player model gained a new property called `inCombat`
which is a flag that indicates whether the player is in combat or not.

Given that `Player` is a model that's detached from the game state, this
flag must be updated manually by the addon developer. However, the library
`currentPlayer` in combat status is synchronized with the game state by
watching the [combat status events](../facades/events#player_entered_combat),
which means doing the following...

```lua
library.currentPlayer.inCombat
```

...at any point in time will return the current combat status of the player.