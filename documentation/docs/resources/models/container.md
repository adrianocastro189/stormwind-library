# Container

The Container model represents bags, bank slots, the player's backpack, and 
any other container capable of holding items.

For a more detailed explanation of the Container model and its available 
methods and properties, please refer to the library
[technical documentation](pathname:///lua-docs/classes/Models.Container.html).

## Getting an updated container list of items

When instantiated, the container instance has no items stored yet.

Given that items are cached internally, when calling `getItems()` in a brand 
new instance will result in a container scan to populate the list.

After that, the `refresh()` method should be called.

```lua
local backpack = library
    :new('Container')
    :setSlot(Enum.BagIndex.Backpack)

local itemsInBackpack = backpack:getItems()

-- later in another part of the code if the backpack instance is reused
local updatedItemsInBackpack = backpack:refresh():getItems()
```

:::tip Getting the available slot constants

A list of slots can be found with `/dump Enum.BagIndex` in game.

At the time of writing (June 2024), the command above returns the same results
for Classic Era, Cataclysm Classic and Dragonflight.

:::

## The outdated flag

A flag called `outdated` was introduced in the library version 1.8.0 to set a
state in a container instance that indicates that the items list is outdated.

Along with this flag, the `getItems()` method was updated to also look for the
`outdated` flag and refresh the items list if it's true, along with the `nil`
check that was already in place.

Calling `flagOutdated()` in a container instance will tell its methods to 
refresh the items list **when needed.** This is important to avoid having to 
map the items multiple times when events like `BAG_UPDATE` are triggered. With 
the flag, regardless of the number of events letting the container instance 
know that the items list is outdated, it will only refresh when they are 
requested.