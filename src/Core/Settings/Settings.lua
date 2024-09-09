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
    Adds a setting to a group represented by its id.

    @tparam Core.Settings.Setting setting The setting to be added
    @tparam string group The id of the group to which the setting will be added

    @treturn Core.Settings.Settings self
    ]]
    function Settings:addSetting(setting, group)
        -- @TODO: Implement this method in SS4 <2024.09.09>
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
    Gets all the settings that were configured in the addon properties to convert
    them into real setting and setting group instances.

    Although not a local method, addons shouldn't call this method directly as it
    is meant to be called by the library during the initialization process.
    ]]
    function Settings:mapFromAddonProperties()
        -- @TODO: Implement this method in AP2 <2024.09.09>
    end

    --[[--
    Maybe adds the general setting group to the list of setting groups if it doesn't
    already exist.

    @local
    ]]
    function Settings:maybeAddGeneralGroup()
        -- @TODO: Implement this method in SS3 <2024.09.09>
    end

    --[[--
    Gets a setting instance by its fully qualified id.

    @tparam string settingFullyQualifiedId The fully qualified id of the setting

    @treturn Core.Settings.Setting|nil The setting instance
    ]]
    function Settings:setting(settingFullyQualifiedId)
        -- @TODO: Implement this method in SS5 <2024.09.09>
    end
-- end of Settings