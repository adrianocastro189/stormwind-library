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
    Gets all the setting instances that are stored in the setting groups.

    @treturn table[Core.Settings.Setting] The setting instances
    ]]
    function Settings:all()
        -- @TODO: Implement this method in SS1A <2024.09.09>
    end

    --[[--
    Gets all the command accessible setting instances that are stored in the
    setting groups.

    @treturn table[Core.Settings.Setting] The setting instances that are accessible by command
    ]]
    function Settings:allAccessibleByCommand()
        -- @TODO: Implement this method in SS1B <2024.09.09>
    end

    --[[--
    Determines whether the addon has at least one setting.

    @treturn boolean Whether the addon has at least one setting
    ]]
    function Settings:hasSettings()
        -- @TODO: Implement this method in SS1A <2024.09.09>
    end

    --[[--
    Determines whether the addon has at least one setting that is accessible by
    command.

    @treturn boolean Whether the addon has at least one setting that is accessible by command
    ]]
    function Settings:hasSettingsAccessibleByCommand()
        -- @TODO: Implement this method in SS1B <2024.09.09>
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
    Maybe creates the library Settings instance if the library configuration is
    enabled.

    This method works as a static method that shouldn't be called directly by
    addons. It's just a way to isolate its logic from the library onLoad callback,
    which is the only place where it should be called.

    If configuration is not enabled, this method will bail out early and won't
    create any Settings instance.

    @local
    ]]
    function Settings.maybeCreateLibraryInstance()
        local library = Settings.__
        if library:isConfigEnabled() then
            library.settings = library:new('Settings')
            -- proxy method to get a setting instance by its fully qualified id
            library.setting = function(self, settingFullyQualifiedId)
                return self.settings:setting(settingFullyQualifiedId)
            end
        end
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

self:onLoad(function()
    -- may create the library Settings instance
    self:getClass('Settings').maybeCreateLibraryInstance()
end)