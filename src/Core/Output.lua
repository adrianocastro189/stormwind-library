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
    Colors a string with a given color according to how
    World of Warcraft handles colors in the chat and output.

    This method first looks for the provided color, if it's not
    found, it will use the primary color from the addon properties.
    And if the primary color is not found, it won't color the string,
    but return it as it is.

    @tparam string value
    @tparam string color
    @treturn string
    ]]
    function Output:color(value, --[[optional]] color)
        color = color or self.__.addon.colors.primary

        return color and string.gsub('\124cff' .. string.lower(color) .. '{0}\124r', '{0}', value) or value
    end

    --[[
    Formats a standard message with the addon name to be printed.

    @tparam string message
    ]]
    function Output:getFormattedMessage(message)
        local coloredAddonName = self:color(self.__.addon.name)

        return string.format('%s | %s',
            coloredAddonName,
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