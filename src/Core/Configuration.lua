--[[--
The Configuration class is responsible for managing the addon's
configurations, settings, options, and anything else that can be persisted
in the table used by the game client to store saved variables.

It provides methods to easily access and manipulate the configuration
properties. That reduces the need to pollute the addon code with sanity
checks, index initializations, etc.

All the configuration keys in this class can be accessed using the dot
notation, similar to the how the Arr class works.

@classmod Core.Configuration
]]
local Configuration = {}
    Configuration.__index = Configuration
    Configuration.__ = self

    --[[--
    Configuration constructor.

    The configuration instance expects a table with the configuration data
    which is also referenced in the TOC file. That way, each instance of this
    class will handle a saved variable.

    Stormwind Library will automatically create an instance of this class
    when the addon is loaded in case a table is referenced in the addon's
    properties, however, if the addon needs to have multiple configurations,
    one instance of this class should be created for each table.

    @tparam table savedVariable The configuration data to be used by the addon.
            This table instance must be the same one referenced in
            the TOC SavedVariables property.
    ]]
    function Configuration.__construct(savedVariable)
        local self = setmetatable({}, Configuration)

        self.data = savedVariable

        return self
    end

    --[[--
    Gets a configuration property by a dot notation key or returns a default
    value if the key does not exist.

    @tparam string key The dot notation key to be used to retrieve the configuration property
    @tparam any default The default value to be returned if the key does not exist

    @treturn any The configuration property value or the default value if the
                 key does not exist
    
    @usage
        library.configuration:get('test.property', 'default-value')
    ]]
    function Configuration:get(key, default)
        return self.__.arr:get(self.data, self:maybePrefixKey(key), default)
    end

    --[[--
    Gets a configuration property by a dot notation key or initializes it
    with a default value if the key does not exist.

    This method is similar to the get() method, but it also initializes the
    property with the default value if the key does not exist.

    @see Configuration.get

    @tparam string key The dot notation key to be used to retrieve the configuration property
    @tparam any default The default value to be returned if the key does not exist

    @treturn any The configuration property value or the default value if the
                 key does not exist

    @usage
        library.configuration:getOrInitialize('test.property', 'default-value')
    --]]
    function Configuration:getOrInitialize(key, default)
        self.__.arr:maybeInitialize(self.data, self:maybePrefixKey(key), default)

        return self:get(key, default)
    end

    --[[--
    The handle method is used forward the configuration operation coming
    from the library config() method.

    This method should not be called directly. It is used internally by the
    library to handle the configuration operations.

    @local
    ]]
    function Configuration:handle(...)
        if self.data == nil then
            self.__.output:out('There was an attempt to get or set configuration values with no addon respective data set. Please, pass the data variable name when initializing the Stormwind Library to use this feature.')
            return nil
        end

        local arg1, arg2, arg3 = ...

        if type(arg1) == 'string' then
            if self.__.bool:isTrue(arg3) then
                return self:getOrInitialize(arg1, arg2)
            else
                return self:get(arg1, arg2)
            end
        end

        if type(arg1) == 'table' then
            self.__.arr:each(arg1, function(value, key)
                self:set(key, value)
            end)
        end

        return nil
    end

    --[[--
    Prefixes a key with the prefix key if it's set.

    This method is used internally to prefix the configuration keys with the
    prefix key if it's set. It should not be called directly, especially
    when getting or setting configuration properties, otherwise the prefix
    may be added twice.

    @local

    @tparam string key The key to be prefixed

    @treturn string The key with the prefix if it's set, or the key itself
    ]]
    function Configuration:maybePrefixKey(key)
        return self.prefixKey and self.prefixKey .. '.' .. key or key
    end

    --[[--
    Sets a configuration property by a dot notation key.

    This will update the configuration property with the new value. If the key
    does not exist, it will be created.

    @tparam string key The dot notation key to be used to set the configuration property
    @tparam any value The value to be set in the configuration property

    @usage
        library.configuration:set('test.property', 'new-value')
    --]]
    function Configuration:set(key, value)      
        self.__.arr:set(self.data, self:maybePrefixKey(key), value)
    end

    --[[--
    Sets a prefix key that will be used to prefix all the configuration keys.

    If this method is not called during the addon lifecycle, no prefixes
    will be used.

    One of the reasons to use a prefix key is to group configuration values
    and settings per player, realm, etc.

    Note: The prefix will be concatenated with a dot before any key used in
    this class, which means that this method should not be called with a
    prefix key that already ends with a dot.

    @tparam string value The prefix key to be used to prefix all the configuration keys

    @treturn Core.Configuration The Configuration instance itself to allow method chaining
    ]]
    function Configuration:setPrefixKey(value)
        self.prefixKey = value
        return self
    end
-- end of Configuration

self:addClass('Configuration', Configuration)

--[[
Gets, sets or initializes a configuration property by a dot notation key.

This is the only method that should be used to handle the addon
configuration, unless the addon needs to have multiple configuration
instances.

config() is a proxy method that forwards the configuration operation to the
Configuration class that's internally handled by Configuration:handle().

@see Configuration.handle
]]
function self:config(...)
    if not self:isConfigEnabled() then return nil end

    return self.configuration:handle(...)
end

--[[
Determines whether the addon configuration is enabled.

To be enabled, the addon must have a configuration instance created, which
is instantiated by the library when the addon is loaded if it has a saved
variable property in the TOC file passed to the library constructor.

@treturn bool True if the configuration is enabled, false otherwise
--]]
function self:isConfigEnabled()
    -- @TODO: Remove this method once the library offers a structure to
    --        execute callbacks when it's loaded <2024.04.22>
    self:maybeInitializeConfiguration()

    return self.configuration ~= nil
end

--[[
May initialize the addon configuration if it's not set yet.

@TODO: Remove this method once the library offers a structure to execute
       callbacks when it's loaded <2024.04.22>
]]
function self:maybeInitializeConfiguration()
    local key = self.addon.data
    if key and (self.configuration == nil) then
        -- initializes the addon data if it's not set yet
        _G[key] = self.arr:get(_G, key, {})
        
        -- global configurations
        self.configuration = self:new('Configuration', _G[key])

        -- player configurations
        self.playerConfiguration = self:new('Configuration', _G[key])
        self.playerConfiguration:setPrefixKey(self.currentPlayer.realm.name .. '.' .. self.currentPlayer.name)
    end
end

--[[
Gets, sets or initializes a player configuration property by a dot notation
key.

This is the only method that should be used to handle the addon
player configurations, unless the addon needs to have multiple configuration
instances.

playerConfig() is a proxy method that forwards the configuration operation
to the player Configuration instance that's internally handled by
Configuration:handle().

@see Configuration.handle
]]
function self:playerConfig(...)
    if not self:isConfigEnabled() then return nil end

    return self.playerConfiguration:handle(...)
end