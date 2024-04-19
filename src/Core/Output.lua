--[[--
The output structure controls everything that can be printed
in the Stormwind Library and also by the addons.

@classmod Output
]]
local Output = {}
    Output.__index = Output
    Output.__ = self

    --[[--
    Output constructor.
    ]]
    function Output.__construct()
        local self = setmetatable({}, Output)

        self.mode = 'out'

        return self
    end

    --[[--
    Colors a string with a given color according to how
    World of Warcraft handles colors in the chat and output.

    This method first looks for the provided color, if it's not
    found, it will use the primary color from the addon properties.
    And if the primary color is not found, it won't color the string,
    but return it as it is.

    @tparam string value The string to be colored
    @tparam string color The color to be used

    @treturn string The colored string
    ]]
    function Output:color(value, color)
        color = color or self.__.addon.colors.primary

        return color and string.gsub('\124cff' .. string.lower(color) .. '{0}\124r', '{0}', value) or value
    end

    --[[--
    Formats a standard message with the addon name to be printed.

    @tparam string message The message to be formatted

    @treturn string The formatted message
    ]]
    function Output:getFormattedMessage(message)
        local coloredAddonName = self:color(self.__.addon.name .. ' | ')

        return coloredAddonName .. message
    end

    --[[--
    Determines whether the output structure is in testing mode.

    @treturn boolean Whether the output structure is in testing mode
    ]]
    function Output:isTestingMode()
        return self.mode == 'test'
    end

    --[[--
    This is the default printing method for the output structure.
    
    Although there's a print() method in the output structure, it's
    recommended to use this method instead, as it will format the
    message with the addon name and color it according to the
    primary color from the addon properties.

    This method accepts a string or an array. If an array is passed
    it will print one line per value.

    @tparam table[string]|string messages The message or messages to be printed
    ]]
    function Output:out(messages)
        for i, message in ipairs(self.__.arr:wrap(messages)) do
            if self:isTestingMode() then
                table.insert(self.history, message)
                return
            end

            self:print(self:getFormattedMessage(message))
        end
    end

    --[[--
    Prints a message using the default Lua output resource.

    @tparam string message The message to be printed
    ]]
    function Output:print(message)
        print(message)
    end

    --[[--
    Determines whether a message was printed in the output structure with
    the out() method.

    This method must be used only in test environments and if
    self:setTestingMode() was called before self:out() calls, otherwise
    it will always return false.

    @tparam string message The message to be checked if it was printed

    @treturn boolean Whether the message was printed
    ]]
    function Output:printed(message)
        return self.__.arr:inArray(self.history or {}, message)
    end

    --[[--
    Sets the output mode to 'test', changing the state of the output
    structure to be used in tests.
    ]]
    function Output:setTestingMode()
        self.history = {}
        self.mode = 'test'
    end
-- end of Output

-- sets the unique library output instance
self.output = Output.__construct()

-- allows Output to be instantiated, very useful for testing
self:addClass('Output', Output)