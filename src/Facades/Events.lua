--[[
Class description.
]]
local Events = {}
    Events.__index = Events
    Events.__ = self
    self:addClass('Events', Events)

    --[[
    Events constructor.
    ]]
    function Events.__construct()
        local self = setmetatable({}, Events)

        return self
    end
-- end of Events

self.events = self:new('Events')