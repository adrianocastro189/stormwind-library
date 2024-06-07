--[[--
This model represents the group of all player containers condensed as a
single concept.

It's a concept because the game doesn't have a visual inventory, but it
shows the items inside bags, bank slots, keyring, etc, that are mapped as
containers, while the inventory is the "sum" of all these containers.

@classmod Models.Inventory
]]
local Inventory = {}
    Inventory.__index = Inventory
    Inventory.__ = self
    self:addClass('Inventory', Inventory)

    --[[--
    Inventory constructor.
    ]]
    function Inventory.__construct()
        return setmetatable({}, Inventory)
    end

    --[[--
    Gets all items from the inventory.

    This method will return all items from all containers mapped in the
    inventory.

    Make sure to call this method after any actions that trigger the
    inventory mapping (refresh), to get the most updated items.
    ]]
    function Inventory:getItems()
    -- @TODO: Implement this method in IV3 <2024.06.06>
    end

    --[[--
    Determines whether the inventory has a specific item.

    @tparam int|Models.Item The item ID or item instance to search for

    @treturn boolean
    ]]
    function Inventory:hasItem(item)
    -- @TODO: Implement this method in IV3 <2024.06.06>
    end

    --[[--
    Maps all player containers in the inventory internal list.

    This method will also trigger the mapping of the containers slot, so
    it's expected to have the player items synchronized after this method
    is called.

    @treturn Models.Inventory self
    ]]
    function Inventory:mapBags()
        if not self.__.arr:get(_G, 'Enum.BagIndex') then
            return
        end

        self.containers = {}

        self.__.arr:each(Enum.BagIndex, function (bagId, bagName)
            local container = self.__:new('Container')
                :setSlot(bagId)
                :mapItems()

            table.insert(self.containers, container)
        end)

        return self
    end

    --[[--
    Iterates over all containers in the inventory and refreshes their items.

    @treturn Models.Inventory self
    ]]
    function Inventory:refresh()
        self.__.arr:each(self.containers, function (container)
            container:refresh()
        end)

        return self
    end
-- end of Inventory

-- @TODO: Find a way to keep it refreshed automatically in IV3 <2024.06.06>
self.playerInventory = self:new('Inventory')