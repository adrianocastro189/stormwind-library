--[[--
This model represents bags, bank bags, the player'self backpack, and any other
container capable of holding items.

@classmod Models.Container
]]
local Container = {}
    Container.__index = Container
    Container.__ = self
    self:addClass('Container', Container)

    --[[--
    Container constructor.
    ]]
    function Container.__construct()
        return setmetatable({}, Container)
    end

    --[[--
    Gets the item information for a specific slot in the container using the
    game's C_Container.GetContainerItemInfo API method.

    @internal

    @tparam int slot The internal container slot to get the item information from

    @treturn table[string]|nil The item information (if any) in a specific slot
    ]]
    function Container:getContainerItemInfo(slot)
        return C_Container.GetContainerItemInfo(self.slot, slot)
    end

    --[[--
    Gets the container's items.

    Important note: this method may scan the container for items only once.
    After that, it will return the cached list of items. It's necessary to
    call self:refresh() to update the list of items in case the caller needs
    the most up-to-date list, unless there's an event listener updating them
    automatically.

    @treturn table[Models.Item] the container's items
    ]]
    function Container:getItems()
        if self.items == nil then
            self:mapItems()
        end

        return self.items
    end

    --[[--
    Gets the number of slots in the container.

    @treturn int the number of slots in the container
    ]]
    function Container:getNumSlots()
        return C_Container.GetContainerNumSlots(self.slot)
    end

    --[[--
    Determines whether the container has a specific item.

    @tparam int|Models.Item The item ID or item instance to search for

    @treturn boolean
    ]]
    function Container:hasItem(item)
        local arr = self.__.arr

        return arr:any(self:getItems(), function (itemInContainer)
            return itemInContainer.id == arr:get(arr:wrap(item), 'id', item)
        end)
    end

    --[[--
    Scans the container represented by self.slot and updates its internal
    list of items.

    @NOTE: This method was designed to be updated in the future when the
    container class implements a map with slot = item positions. For now,
    it's a simple item mapping that updated the internal items cache.

    @treturn Models.Container self
    ]]
    function Container:mapItems()
        self.items = {}

        for slot = 1, self:getNumSlots() do
            local itemInformation = self:getContainerItemInfo(slot)
            local item = self.__.itemFactory:createFromContainerItemInfo(itemInformation)
            table.insert(self.items, item)
        end

        return self
    end

    --[[--
    This is just a facade for the mapItems() method to improve readability.

    The refresh method just updates the container's internal list of items
    to reflect the current state of the player's container.

    @see Models.Container.mapItems

    @treturn Models.Container self
    ]]
    function Container:refresh()
        return self:mapItems()
    end

    --[[--
    Sets the container slot.

    The slot represents the container's position in the player's inventory.
    
    A list of slots can be found with "/dump Enum.BagIndex" in game.

    @tparam int value the container's slot

    @treturn Models.Container self
    ]]
    function Container:setSlot(value)
        self.slot = value
        return self
    end
-- end of Container