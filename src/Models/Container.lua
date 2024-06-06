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
    Scans the container represented by self.slot and updates its internal
    list of items.

    @treturn Models.Container self
    ]]
    function Container:mapItems()
        -- @TODO: Implement this method in BG4 <2024.06.06>
        return self
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