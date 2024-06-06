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

    --[[--
    Creates an item instance from container item information, which is a table
    with lots of item properties that usually comes from the game API
    functions like C_Container.GetContainerItemInfo().

    Of course, this method extracts only the properties mapped in the Item
    model, and it will be improved to cover more of them in the future in
    case they are needed.

    The properties accepted in this method can be dumped from the game using
    a slash command like "/dump C_Container.GetContainerItemInfo(0, 1)" and
    making sure there's an item in the first slot of the backpack.

    @tparam table[string] containerItemInfo A table containing item information

    @treturn Models.Item The item instance created from the container item
    ]]
    function ItemFactory:createFromContainerItemInfo(containerItemInfo)
        if not containerItemInfo then
            return nil
        end

        local arr = self.__.arr

        return self.__:new('Item')
            :setName(arr:get(containerItemInfo, 'itemName'))
            :setId(arr:get(containerItemInfo, 'itemID'))
    end
-- end of ItemFactory

self.itemFactory = ItemFactory.__construct()