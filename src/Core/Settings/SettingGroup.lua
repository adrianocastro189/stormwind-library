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

        self.settings = {}

        return self
    end

    --[[--
    Adds a setting to the group.

    @tparam Core.Settings.Setting setting The setting to be added

    @treturn Core.Settings.SettingGroup self
    ]]
    function SettingGroup:addSetting(setting)
        self.settings[setting.id] = setting
        setting:setGroup(self)
        return self
    end

    --[[--
    Gets all settings in this group.

    @treturn table[Core.Settings.Setting] All the settings in this group
    ]]
    function SettingGroup:all()
        return self.settings
    end

    --[[--
    Gets all settings in this group that are accessible by a command.

    @treturn table[Core.Settings.Setting] All the settings in this group that are accessible by a command
    ]]
    function SettingGroup:allAccessibleByCommand()
        return self.__.arr:filter(self.settings, function(setting)
            return setting:isAccessibleByCommand()
        end)
    end

    --[[--
    Gets a setting in this group by its id.

    It's important to pass the setting id, not the fully qualified id.

    @tparam string id The setting id

    @treturn Core.Settings.Setting|nil The setting instance
    ]]
    function SettingGroup:getSetting(id)
        return self.settings[id]
    end

    --[[--
    Gets a setting value in this group by its id.

    It's important to pass the setting id, not the fully qualified id.

    @tparam string id The setting id

    @treturn any|nil The setting value
    ]]
    function SettingGroup:getSettingValue(id)
    -- @TODO: Implement this method in SG4 <2024.09.07>
    end

    --[[--
    Determines whether this group has settings.

    @treturn boolean Whether this group has settings
    ]]
    function SettingGroup:hasSettings()
        return self.__.arr:count(self.settings) > 0
    end

    --[[--
    Determines whether this group has at least one settings that's accessible by a command.

    @treturn boolean Whether this group has at least one settings that's accessible by a command
    ]]
    function SettingGroup:hasSettingsAccessibleByCommand()
        return self.__.arr:any(self.settings, function(setting)
            return setting:isAccessibleByCommand()
        end)
    end

    --[[--
    Sets the setting group id.

    @tparam string value The setting group's id

    @treturn Core.Settings.SettingGroup self
    ]]
    function SettingGroup:setId(value)
        self.id = value
        return self
    end

    --[[--
    Sets the setting group label.

    @tparam string value The setting group's label

    @treturn Core.Settings.SettingGroup self
    ]]
    function SettingGroup:setLabel(value)
        self.label = value
        return self
    end
-- end of SettingGroup