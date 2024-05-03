--[[--
The Item class is a model that maps game items and their properties.

Just like any other model, it's used to standardize the way addons interact 
with game objects, especially when item information is passed as a parameter
to methods, events, datasets, etc.

This model will grow over time as new expansions are released and new
features are implemented in the library.

@classmod Models.Item
]]
local Item = {}
    Item.__index = Item
    Item.__ = self
    self:addClass('Item', Item)

    --[[--
    Item constructor.
    ]]
    function Item.__construct()
        return setmetatable({}, Item)
    end

    --[[--
    Sets the item name.

    @tparam string value the item's name

    @treturn Models.Item self
    ]]
    function Item:setName(value)
        self.name = value
        return self
    end
-- end of Item