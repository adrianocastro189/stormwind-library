# Realm

The Realm class is a model that maps realm, or server, information.

Just like any other model, it's used to standardize the way addons interact 
with realm data.

Its first version, introduced in the library version 1.2.0 includes only the
`name` property, but this model will grow over time as new expansions are 
released and new features are implemented in the library.

For a more detailed explanation of the Realm model and its available methods 
and properties, please refer to the library
[technical documentation](../../library-structure/luadocs#generated-docs).

## Getting the current realm instance

The current realm instance can be retrieved using a "static" method of the
Realm class, which also takes care of creating the instance and setting the
realm name using the World of Warcraft API.

```lua
local realm = library:getClass('Realm').getCurrentRealm()
```

Note that the example above is not not calling `:getCurr...` but
`.getCurr...` because this method is associated with the class itself, not 
with an instance of the class.