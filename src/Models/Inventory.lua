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
    Maps all player bags as containers in the inventory internal list.

    This method will also trigger the mapping of the containers slot, so
    it's expected to have the player items synchronized after this method
    is called.
    ]]
    function Inventory:mapBags()
    -- @TODO: Implement this method in IV2 <2024.06.06>
    end
-- end of Inventory