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

## Marking a target with a raid marker

Target has a method called `mark()` which accepts a [raid marker](../models/raid-marker)
parameter and then marks the current target (if any).

This is a facade for `SetRaidTarget()`.

```lua
local skullMarker = library.raidMarkers.skull

library.target:mark(skullMarker)
```