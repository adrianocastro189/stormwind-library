--[[
The output structure controls everything that can be printed
in the Stormwind Library and also by the addons.
]]
local Output = {}
    Output.__index = Output
    Output.__ = self

    --[[
    Output constructor.
    ]]
    function Output.__construct()
        return setmetatable({}, Output)
    end

    --[[
    Formats a standard message with the addon name to be printed.

    @tparam string message
    ]]
    function Output:getFormattedMessage(message)
        return string.format('%s | %s',
            self.__.addon.name,
            message
        )
    end

    --[[
    Prints a message using the default Lua output resource.
    ]]
    function Output:print(message)
        print(message)
    end
-- end of Output

-- sets the unique library output instance
self.output = Output.__construct()

-- allows Output to be instantiated, very useful for testing
self:addClass('Output', Output)