--[[--
Settings is the class that holds all the settings for the addon.

It maintains a list of setting groups, which in turn maintain a list of settings.

@classmod Core.Settings.Settings
]]
local Settings = {}
    Settings.__index = Settings
    Settings.__ = self
    self:addClass('Settings', Settings)

    --[[--
    Settings constructor.
    ]]
    function Settings.__construct()
        local self = setmetatable({}, Settings)

        -- add properties here

        return self
    end
-- end of Settings