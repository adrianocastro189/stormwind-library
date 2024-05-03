--[[--
The Item class is a model that maps game items and their properties.

An instance of item can be used the item related events are fired as a way
standardize item information, considering that they change a lot on each
expansion.

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