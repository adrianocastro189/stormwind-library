# Raid Marker

The raid marker model represents those icon markers that can
be placed on targets, mostly used in raids and dungeons, especially
💀 and ❌.

This model is used to represent the raid markers in the game, but
not only conceptually, but it maps markers and their indexes to
be represented by objects in the addon environment.

## Instances

Raid Marker's constructor is private, which means this model can't be
freely instantiated. The reason for that is: there's a limited number
of markers in the game, and each instance is not supposed to store any
kinds of state, nor persistent data. In other words, this class behaves
as an enum.

The only way to obtain markers instances is by getting them from the
library's `raidMarkers` property, which stores the possible 9 markers,
being the 0 marker just a way to remove a target mark. So, in fact, only
8 instances are real markers.

Raid markers can be obtained by their name or numeric id:

```lua
library.raidMarkers['remove']   -- or library.raidMarkers[0]
library.raidMarkers['star']     -- or library.raidMarkers[1]
library.raidMarkers['circle']   -- or library.raidMarkers[2]
library.raidMarkers['diamond']  -- or library.raidMarkers[3]
library.raidMarkers['triangle'] -- or library.raidMarkers[4]
library.raidMarkers['moon']     -- or library.raidMarkers[5]
library.raidMarkers['square']   -- or library.raidMarkers[6]
library.raidMarkers['x']        -- or library.raidMarkers[7]
library.raidMarkers['skull']    -- or library.raidMarkers[8]
```

## Printable string

Raid markers can be printed in the World of Warcraft default output,
which is the chat window. That requires a big string that includes the
numeric identifier representing the marker.

The `RaidMarker` class encapsulates that logic in a method called
`getPrintableString()`. The example below will print the 💀 icon in
the chat.

```lua
local skullMarker = library.raidMarkers['skull']

print(skullMarker:getPrintableString() .. ' - this is a skull raid marker')
```