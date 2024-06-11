# ItemFactory

Creates item instances from multiple sources.

This factory is responsible for being able to instantiate
[item](../models/item) objects from different sources, such as item links, 
item ids, item names, complex strings containing item information and any 
other source that's available in the game that can be used to identify an item.

For a complete list of methods available in this factory, please refer to the
[LuaDocs ItemFactory page](pathname:///lua-docs/classes/Factories.ItemFactory.html)

## Usage

In game, it's possible to run a slash command to get item information from any
item in a bag or in the backpack itself.

```
/dump C_Container.GetContainerItemInfo(0, 1)
```

This command will return a table with a few item properties and this table can
be passed to the factory to create an item instance.

```lua
local info = C_Container.GetContainerItemInfo(0, 1)
local item = library.itemFactory:createFromContainerItemInfo(info)
```