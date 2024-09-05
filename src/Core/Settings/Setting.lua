--[[--
A setting is basically a configuration value that can be changed by players.

Although a setting instance uses Core.Configuration internally for storage purposes,
it's not meant to be used as a configuration value. Configuration values are wider
and can be used in many ways, like saving UI states and even addon data. Settings
are meant to allow players to change the behavior of the addon.

@classmod Core.Settings.Setting
]]
local Setting = {}
    Setting.__index = Setting
    Setting.__ = self
    self:addClass('Setting', Setting)

    --[[--
    Setting constructor.
    ]]
    function Setting.__construct()
        local self = setmetatable({}, Setting)

        -- add properties here

        return self
    end
-- end of Setting