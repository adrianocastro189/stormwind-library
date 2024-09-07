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
        -- @TODO: Implement this method in SG2 <2024.09.07>
        return self
    end

    --[[--
    Gets all settings in this group.

    @treturn table[Core.Settings.Setting] All the settings in this group
    ]]
    function SettingGroup:all()
    -- @TODO: Implement this method in SG1A <2024.09.07>
    end

    --[[--
    Gets all settings in this group that are accessible by a command.

    @treturn table[Core.Settings.Setting] All the settings in this group that are accessible by a command
    ]]
    function SettingGroup:allAccessibleByCommand()
    -- @TODO: Implement this method in SG1B <2024.09.07>
    end

    --[[--
    Gets a setting in this group by its id.

    It's important to pass the setting id, not the fully qualified id.

    @tparam string id The setting id

    @treturn Core.Settings.Setting|nil The setting instance
    ]]
    function SettingGroup:getSetting(id)
    -- @TODO: Implement this method in SG3 <2024.09.07>
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
    -- @TODO: Implement this method in SG1A <2024.09.07>
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