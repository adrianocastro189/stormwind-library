# Inventory

The [Container](container) model introduced a mapped object to represent bags,
bank slots, the player's backpack, and any other container capable of holding
items.

The Inventory model is a concept that **groups all containers** available to 
the player in a way to represent all items the player has.

Although instantiable just like almost every model in the Stormwind Library,
it's recommended to use the instance stored in the library object as a good
source of truth.

## Getting the player's inventory

Once instantiated, the library will automatically instantiate the player's
inventory and store its instance. After that, it will "try its best" to keep
it updated with the player's containers, so it's the best source of truth for
getting the player's inventory items.

```lua
local playerItems = library.playerInventory:getItems()
```