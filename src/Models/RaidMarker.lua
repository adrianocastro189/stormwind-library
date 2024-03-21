--[[
The raid marker model represents those icon markers that can
be placed on targets, mostly used in raids and dungeons, especially
skull and cross (x).

This model is used to represent the raid markers in the game, but
not only conceptually, but it maps markers and their indexes to
be represented by objects in the addon environment.
]]
local RaidMarker = {}
    RaidMarker.__index = RaidMarker
    RaidMarker.__ = self

    --[[
    The raid marker constructor.
    ]]
    function RaidMarker.__construct(id, name)
        local self = setmetatable({}, RaidMarker)

        self.id = id
        self.name = name

        return self
    end

    --[[
    Returns a string representation of the raid marker that can
    be used to print it in the chat output in game.
    ]]
    function RaidMarker:getPrintableString()
        if self.id == 0 then
            -- the raid marker represented by 0 can't be printed
            return ''
        end

        return '\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_' .. self.id .. ':0\124t'
    end
-- end of RaidMarker

self.TEMPORARY_RAID_MARKER = RaidMarker.__construct(1, 'TEMPORARY')