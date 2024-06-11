# Inventory

The [Container](container) model introduced a mapped object to represent bags,
bank slots, the player's backpack, and any other container capable of holding
items.

The Inventory model is a concept that **groups all containers** available to 
the player in a way to represent all items the player has.

Although instantiable just like almost every model in the Stormwind Library,
it's recommended to use the instance stored in the library object as a good
source of truth.

For a more detailed explanation of the Inventory model and its available 
methods and properties, please refer to the library
[technical documentation](pathname:///lua-docs/classes/Models.Inventory.html).

## Inventory tracking

When the library is instantiated, it's possible to tell it to track the 
player's inventory by setting the `inventory.track` property to `true`
(read more [here](../core/addon-properties#inventory)). **By default, it won't
track inventory, at least until its performance is measured and improved.**

If inventory tracking is set to `true`, upon initialization, the library will 
automatically instantiate the player's inventory and store its instance. After 
that, it will "try its best" to keep it updated with the player's containers, 
so it's the best source of truth for getting the player's inventory items.

```lua
-- this will return a table with instances of Item
local playerItems = library.playerInventory:getItems()
```

:::danger Careful with inventory management, at least for now

The inventory tracking feature is still experimental as of version 1.4.0, when
it was introduced. It's recommended to use it with caution and expect changes
in future versions, especially in performance.

By default, the library won't track the player's inventory.

:::

### What's available in inventory tracking?

1. Updates when the player's bags are updated, which means the
`library.playerInventory` instance will be updated when players get, remove,
move, etc, items in their bags.
1. Items mapped as objects with the [Item](item) model, so it's possible to
access all item properties and methods and implement new features in the next
versions.

### What's not available yet?

1. Caching items in bank slots
1. Item quantities
1. Slot mapping
1. Programmatically item operations like moving, removing

### What's on the radar for future versions of inventory tracking?

1. The items listed above
1. **Performance improvements** - as of now, every `BAG_UPDATE` event will
trigger a full inventory update and that should be reviewed in the future,
because sometimes this event may be triggered multiple times in a short period
of time, so it's important to polish this feature to avoid performance issues.