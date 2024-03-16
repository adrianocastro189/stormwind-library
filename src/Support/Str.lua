--[[
The Str support class contains helper functions to manipulate strings.
]]
local Str = {}
    Str.__index = Str

    --[[
    Splits a string in a table by breaking it where the separator is found.

    @tparam string value
    @tparam string separator

    @treturn table
    ]]
    function Str:split(value, separator)
        local values = {}
        for str in string.gmatch(value, "([^"..separator.."]+)") do
            table.insert(values, str)
        end
        return values
    end
-- end of Str

self.str = Str