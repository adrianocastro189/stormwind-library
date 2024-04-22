--[[--
The Configuration class is responsible for managing the addon's
configuration, settings, options, and anything else that can be persisted
in the table used by the game client to store saved variables.

It provides methods to easily access and manipulate the configuration
properties. That reduces the need to pollute the addon code with sanity
checks, index initializations, etc.

@classmod Core.Configuration
]]
local Configuration = {}
    Configuration.__index = Configuration
    Configuration.__ = self

    --[[--
    Configuration constructor.
    ]]
    function Configuration.__construct()
        local self = setmetatable({}, Configuration)

        return self
    end
-- end of Configuration

self:addClass('Configuration', Configuration)