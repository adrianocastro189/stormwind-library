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
    @tparam[opt='general'] string group The id of the group to which the setting will be added

    @treturn Core.Settings.Settings self
    ]]
    function Settings:addSetting(setting, group)
        group = group or 'general'

        self:maybeAddGeneralGroup()

        self.settingGroups[group]:addSetting(setting)
    end

    --[[--
    Adds a setting group to the list of setting groups.

    @tparam Core.Settings.SettingGroup settingGroup The setting group to be added

    @treturn Core.Settings.Settings self
    ]]
    function Settings:addSettingGroup(settingGroup)
        self.settingGroups[settingGroup.id] = settingGroup
    end

    --[[--
    Gets all the setting instances that are stored in the setting groups.

    @treturn table[Core.Settings.Setting] The setting instances
    ]]
    function Settings:all()
        return self:listSettings('all')
    end

    --[[--
    Gets all the command accessible setting instances that are stored in the
    setting groups.

    @treturn table[Core.Settings.Setting] The setting instances that are accessible by command
    ]]
    function Settings:allAccessibleByCommand()
        return self:listSettings('allAccessibleByCommand')
    end

    --[[--
    Determines whether the addon has at least one setting.

    This method accepts an optional parameter that allows the caller to specify
    the method to be called for each setting group to determine whether it has
    at least one setting. With that, it's possible to add more filters in the future
    without replicating the same logic.

    @tparam[opt='hasSettings'] string settingGroupMethod The method to be called for each setting group

    @treturn boolean Whether the addon has at least one setting
    ]]
    function Settings:hasSettings(settingGroupMethod)
        settingGroupMethod = settingGroupMethod or 'hasSettings'
        return self.__.arr:any(self.settingGroups, function(settingGroup)
            return settingGroup[settingGroupMethod](settingGroup)
        end)
    end

    --[[--
    Determines whether the addon has at least one setting that is accessible by
    command.

    @treturn boolean Whether the addon has at least one setting that is accessible by command
    ]]
    function Settings:hasSettingsAccessibleByCommand()
        return self:hasSettings('hasSettingsAccessibleByCommand')
    end

    --[[--
    Lists settings by invoking a method on each setting group.

    @local

    @tparam string groupMethod The method to be called for each setting group

    @treturn table[Core.Settings.Setting] The setting instances
    ]]
    function Settings:listSettings(groupMethod)
        local settings = {}

        self.__.arr:each(self.settingGroups, function(settingGroup)
            settings = self.__.arr:concat(settings, settingGroup[groupMethod](settingGroup))
        end)

        return settings
    end

    --[[--
    Gets all the settings that were configured in the addon properties to convert
    them into real setting and setting group instances.

    Although not a local method, addons shouldn't call this method directly as it
    is meant to be called by the library during the initialization process.
    ]]
    function Settings:mapFromAddonProperties()
        if self.__.addon.settings == nil then
            return
        end

        self.__.arr:each(self.__.addon.settings.groups, function(group)
            local settingGroup = self.__
                :new('SettingGroup')
                :setId(group.id)
                :setLabel(group.label)

            self:addSettingGroup(settingGroup)

            self.__.arr:each(group.settings, function(setting)
                local settingInstance = self.__
                    :new('Setting')
                    :setId(setting.id)
                    :setLabel(setting.label)
                    :setDescription(setting.description)
                    :setType(setting.type)
                    :setDefault(setting.default)
                    :setScope(setting.scope)
                    :setAccessibleByCommand(setting.accessibleByCommand)

                self:addSetting(settingInstance, group.id)
            end)
        end)
    end

    --[[--
    Maybe adds the general setting group to the list of setting groups if it doesn't
    already exist.

    @local
    ]]
    function Settings:maybeAddGeneralGroup()
        if not self.settingGroups['general'] then
            local generalGroup = self.__
                :new('SettingGroup')
                :setId('general')
                :setLabel('General')

            self:addSettingGroup(generalGroup)
        end
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
            library.settings:mapFromAddonProperties()
            -- proxy method to get a setting instance by its fully qualified id
            library.setting = function(self, settingFullyQualifiedId)
                return self.settings:setting(settingFullyQualifiedId)
            end
        end
    end

    --[[--
    Gets a setting instance by its fully qualified id.

    The fully qualified id is the id of the setting group followed by a dot and
    the id of the setting. If a single setting id is passed, it's assumed to be
    part of the general group.

    @tparam string settingFullyQualifiedId The fully qualified id of the setting

    @treturn Core.Settings.Setting|nil The setting instance
    ]]
    function Settings:setting(settingFullyQualifiedId)
        local id = self.__.str:split(settingFullyQualifiedId, '.')

        local isFullyQualified = #id == 2

        local groupId = isFullyQualified and id[1] or 'general'
        local settingId = isFullyQualified and id[2] or id[1]

        local group = self.settingGroups[groupId]

        return group and group:getSetting(settingId) or nil
    end
-- end of Settings

self:onLoad(function()
    self.events:listen(self.events.EVENT_NAME_PLAYER_LOGIN, function()
        -- initializes the library Settings instance
        self:getClass('Settings').maybeCreateLibraryInstance()
    end)
end)