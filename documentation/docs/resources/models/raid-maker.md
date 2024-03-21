# Raid Marker

The raid marker model represents those icon markers that can
be placed on targets, mostly used in raids and dungeons, especially
skull and cross (x).

This model is used to represent the raid markers in the game, but
not only conceptually, but it maps markers and their indexes to
be represented by objects in the addon environment.

## Printable string

Raid markers can be printed in the World of Warcraft default output,
which is the chat window. That requires a big string that includes the
numeric identifier representing the marker.

The `RaidMarker` class encapsulates that logic in a method called
`getPrintableString()`. The example below will print the 💀 icon in
the chat.

```lua
-- consider skullMarker an instance of RaidMarker
print(skullMarker:getPrintableString() .. ' - this is a skull raid marker')
```