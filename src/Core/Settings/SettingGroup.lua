--[[--
A SettingGroup is a collection of Setting instances.

Settings must belong to a group to exist in an addon context. Groups are mostly used
to organize settings in a logical way and present them to players in a user-friendly
manner.

If an addon doesn't include any groups, all settings will be placed in a general
group.

@classmod Core.Settings.SettingGroup
]]
local SettingGroup = {}
    SettingGroup.__index = SettingGroup
    SettingGroup.__ = self
    self:addClass('SettingGroup', SettingGroup)

    --[[--
    SettingGroup constructor.
    ]]
    function SettingGroup.__construct()
        local self = setmetatable({}, SettingGroup)

        return self
    end
-- end of SettingGroup