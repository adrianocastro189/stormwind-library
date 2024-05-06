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
[technical documentation](../../library-structure/luadocs#generated-docs).

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