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
-- end of Container