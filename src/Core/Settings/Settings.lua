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

        self.settingGroups = {}

        return self
    end

    --[[--
    Adds a setting group to the list of setting groups.

    @tparam Core.Settings.SettingGroup settingGroup The setting group to be added

    @treturn Core.Settings.Settings self
    ]]
    function Settings:addSettingGroup(settingGroup)
        -- @TODO: Implement this method in SS2 <2024.09.09>
    end

    --[[--
    Maybe adds the general setting group to the list of setting groups if it doesn't
    already exist.

    @local
    ]]
    function Settings:maybeAddGeneralGroup()
        -- @TODO: Implement this method in SS3 <2024.09.09>
    end
-- end of Settings