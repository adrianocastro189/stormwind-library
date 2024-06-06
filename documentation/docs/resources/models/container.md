# Container

The Container model represents bags, bank slots, the player's backpack, and 
any other container capable of holding items.

For a more detailed explanation of the Container model and its available 
methods and properties, please refer to the library
[technical documentation](pathname:///lua-docs/classes/Models.Container.html).

## Mapping items

The Container model includes a method to map items which scans the container
represented by its slots and stores an internal list of items.

```lua
-- setSlot() and mapItems() are chainable methods
local container = library
    :new('Container')
    :setSlot(Enum.BagIndex.Backpack)
    :mapItems()
```

:::tip Getting the available slot constants

A list of slots can be found with `/dump Enum.BagIndex` in game.

At the time of writing (June 2024), the command above returns the same results
for Classic Era, Cataclysm Classic and Dragonflight.

:::