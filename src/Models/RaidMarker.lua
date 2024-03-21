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
    function RaidMarker.__construct()
        local self = setmetatable({}, RaidMarker)

        return self
    end
-- end of RaidMarker