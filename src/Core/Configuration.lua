--[[--
The Configuration class is responsible for managing the addon's
configuration, settings, options, and anything else that can be persisted
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

    @tparam string key The dot notation key to be used to retrieve the configuration property.
    @tparam any default The default value to be returned if the key does not exist.

    @treturn any The configuration property value or the default value if the
                 key does not exist.
    
    @usage
        library.configuration:get('test-property', 'default-value')
    ]]
    function Configuration:get(key, default)
        -- @TODO: Implement this method <2024.04.22>
    end

    --[[--
    Gets a configuration property by a dot notation key or initializes it
    with a default value if the key does not exist.

    This method is similar to the get() method, but it also initializes the
    property with the default value if the key does not exist.

    @see Configuration.get

    @tparam string key The dot notation key to be used to retrieve the configuration property.
    @tparam any default The default value to be returned if the key does not exist.

    @treturn any The configuration property value or the default value if the
                 key does not exist.
    --]]
    function Configuration:getOrInitialize(key, default)
        -- @TODO: Implement this method <2024.04.22>
    end

    --[[--
    Sets a configuration property by a dot notation key.

    This will update the configuration property with the new value. If the key
    does not exist, it will be created.

    @tparam string key The dot notation key to be used to set the configuration property.
    @tparam any value The value to be set in the configuration property.
    --]]
    function Configuration:set(key, value)      
        -- @TODO: Implement this method <2024.04.22>
    end
-- end of Configuration

self:addClass('Configuration', Configuration)