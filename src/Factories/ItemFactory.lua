--[[--
Creates item instances from multiple sources.

This factory is responsible for being able to instantiate item objects from
different sources, such as item links, item ids, item names, complex strings
containing item information and any other source that's available in the game
that can be used to identify an item.

@classmod Factories.ItemFactory
]]
local ItemFactory = {}
    ItemFactory.__index = ItemFactory
    ItemFactory.__ = self

    --[[--
    ItemFactory constructor.
    ]]
    function ItemFactory.__construct()
        return setmetatable({}, ItemFactory)
    end
-- end of ItemFactory

self.itemFactory = ItemFactory.__construct()