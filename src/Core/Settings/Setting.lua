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
        PREFIX = '__settings',
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
        return self.__.str:trim(
            self:getFullyQualifiedId() ..
            ' <' .. self.type .. '> ' ..
            (self.description or '')
        )
    end

    --[[--
    Gets the configuration method to be used when saving the setting.

    The configuration method varies between global and player settings, so this
    method returns the proper method to be used in this instance.

    @local

    @treturn string The configuration method
    ]]
    function Setting:getConfigurationMethod()
        return self.scope == self.constants.SCOPE_GLOBAL and 'config' or 'playerConfig'
    end

    --[[--
    Gets the setting fully qualified id.

    The fully qualified id is the setting id prefixed by the group id.

    @treturn string The setting fully qualified id
    ]]
    function Setting:getFullyQualifiedId()
        return self.group.id .. '.' .. self.id
    end

    --[[--
    Gets the setting key, used to store the setting value in the configuration.

    @local

    @treturn string The setting key
    ]]
    function Setting:getKey()
        return self.constants.PREFIX .. '.' .. self:getFullyQualifiedId()
    end

    --[[--
    Gets the setting stored value.

    @treturn any The setting stored value
    ]]
    function Setting:getValue()
        local method = self:getConfigurationMethod()
        local key = self:getKey()

        return self.__[method](self.__, key, self.default)
    end

    --[[--
    Determines whether the setting stored value evaluates to true.

    This is a helper method that returns true if the stored value is any kind of
    value that should be considered true using Support.Bool.

    @see Support.Bool.isTrue

    @treturn boolean Whether the setting stored value evaluates to true
    ]]
    function Setting:isTrue()
        -- @TODO: Implement this method in SE6 <2024.09.05>
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

    --[[--
    Sets the setting value and saves it.

    @tparam any value The setting value

    @treturn Core.Settings.Setting self
    ]]
    function Setting:setValue(value)

        local oldValue = self:getValue()

        if oldValue == value then
            return self
        end

        local id = self:getFullyQualifiedId()
        local key = self:getKey()
        local method = self:getConfigurationMethod()
        
        self.__[method](self.__, {[key] = value})

        self.__.events:notify('SETTING_UPDATED', id, oldValue, value)

        return self
    end
-- end of Setting