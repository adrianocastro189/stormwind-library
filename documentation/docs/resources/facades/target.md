# Target

The target facade maps all the information that can be retrieved by the
World of Warcraft API target related methods.

This class can also be used to access the target with many other purposes,
like setting the target icon, etc.

## How to get the target facade instance

The target facade instance is initialized with the library and can be
easily obtained from the `target` property.

```lua
local targetFacade = library.target
```