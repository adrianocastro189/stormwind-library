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

    Setting.constants = self.arr:freeze({
        SCOPE_GLOBAL = 'global',
        SCOPE_PLAYER = 'player',
        TYPE_BOOLEAN = 'boolean',
        TYPE_NUMBER = 'number',
        TYPE_STRING = 'string',
    })

    --[[--
    Setting constructor.
    ]]
    function Setting.__construct()
        local self = setmetatable({}, Setting)

        self.accessibleByCommand = true
        self.scope = self.constants.SCOPE_PLAYER
        self.type = self.constants.TYPE_STRING

        return self
    end

    --[[--
    Gets a text that explains how to use the setting in a command.

    @treturn string The command help content
    ]]
    function Setting:getCommandHelpContent()
        -- @TODO: Implement this method in SE1A <2024.09.05>
    end

    --[[--
    Gets the configuration method to be used when saving the setting.

    The configuration method varies between global and player settings, so this
    method returns the proper method to be used in this instance.

    @local

    @treturn string The configuration method
    ]]
    function Setting:getConfigurationMethod()
        -- @TODO: Implement this method in SE3 <2024.09.05>
    end

    --[[--
    Gets the setting fully qualified id.

    The fully qualified id is the setting id prefixed by the group id.

    @treturn string The setting fully qualified id
    ]]
    function Setting:getFullyQualifiedId()
        -- @TODO: Implement this method in SE2 <2024.09.05>
    end

    --[[--
    Sets whether the setting is accessible by a command.

    @tparam boolean value Whether the setting is accessible by a command

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setAccessibleByCommand(value)
        self.accessibleByCommand = value
        return self
    end

    --[[--
    Sets the default value of this setting.

    @tparam mixed value The setting's default value

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setDefault(value)
        self.default = value
        return self
    end

    --[[--
    Sets the setting description.

    @tparam string value The setting's description

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setDescription(value)
        self.description = value
        return self
    end

    --[[--
    Sets the setting group.

    @tparam Core.Settings.SettingGroup value The setting's group

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setGroup(value)
        self.group = value
        return self
    end

    --[[--
    Sets the setting id.

    @tparam string value The setting's id

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setId(value)
        self.id = value
        return self
    end

    --[[--
    Sets the setting label.

    @tparam string value The setting's label

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setLabel(value)
        self.label = value
        return self
    end

    --[[--
    Sets the setting scope.

    @tparam string value The setting's scope, listed in Setting.constants

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setScope(value)
        self.scope = value
        return self
    end

    --[[--
    Sets the setting type.

    @tparam string value The setting's type, listed in Setting.constants

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setType(value)
        self.type = value
        return self
    end
-- end of Setting