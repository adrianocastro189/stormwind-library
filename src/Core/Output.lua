--[[--
The output structure controls everything that can be printed
in the Stormwind Library and also by the addons.

@classmod Core.Output
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
    Dumps the values of variables and tables in the output, then dies.

    The dd() stands for "dump and die" and it's a helper function inspired by a PHP framework
    called Laravel. It's used to dump the values of variables and tables in the output and stop
    the execution of the script. It's only used for debugging purposes and should never be used
    in an addon that will be released.

    Given that it can't use the Output:out() method, there's no test coverage for dd(). After
    all it's a test and debugging helper resource.

    @param ... The variables and tables to be dumped

    @usage
        dd(someVariable)
        dd({ key = 'value' })
        dd(someVariable, { key = 'value' })
    ]]
    function Output:dd(...)
        print('\n\n\27[32m-dd-\n')

        local function printTable(t, indent, printedTables)
            indent = indent or 0
            printedTables = printedTables or {}
            local indentStr = string.rep(" ", indent)
            for k, v in pairs(t) do
                if type(v) == "table" then
                    if not printedTables[v] then
                        printedTables[v] = true
                        print(indentStr .. k .. " => {")
                        printTable(v, indent + 4, printedTables)
                        print(indentStr .. "}")
                    else
                        print(indentStr .. k .. " => [circular reference]")
                    end
                else
                    print(indentStr .. k .. " => " .. tostring(v))
                end
            end
        end

        for i, v in ipairs({...}) do
            if type(v) == "table" then
                print("[" .. i .. "] => {")
                printTable(v, 4, {})
                print("}")
            else
                print("[" .. i .. "] => " .. tostring(v))
            end
        end

        print('\n-end of dd-')

        -- this prevents os.exit() being called inside the game and also allows
        -- dd() to be tested
        if os == nil or lu == nil then return end
            
        lu.unregisterCurrentSuite()
        os.exit(1)
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
self.dd = self.output.dd

-- allows Output to be instantiated, very useful for testing
self:addClass('Output', Output)