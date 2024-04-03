--[[
The Str support class contains helper functions to manipulate strings.
]]
local Str = {}
    Str.__index = Str

    --[[
    Determines whether a string is empty or not.

    By empty, it means that the string is nil, has no characters, or has only
    whitespace characters. This last case is important because a string with
    only whitespace characters is not considered empty by Lua's standards,
    but it is by this function's standards.

    If a method shouldn't consider a string with only whitespace characters
    as empty, please do not use this function.
        
    @tparam string value

    @treturn bool
    ]]
    function Str:isEmpty(value)
        return value == nil or (string.len(self:trim(value)) == 0)
    end

    --[[
    Determines whether a string is not empty.

    This function is the opposite of Str:isEmpty.

    @tparam string value

    @treturn bool
    ]]
    function Str:isNotEmpty(value)
        return not self:isEmpty(value)
    end

    --[[
    Determines whether a string is quoted by " or '.

    @tparam string value

    @treturn bool
    ]]
    function Str:isQuoted(value)
        return self:isWrappedBy(value, '"') or self:isWrappedBy(value, "'")
    end

    --[[
    Determines whether a string is wrapped by a prefix and a suffix.

    This function is useful to determine if a string is wrapped by a pair of
    strings, like quotes, parentheses, brackets, etc.

    The third parameter is optional. If it is not provided, the function will
    assume that the prefix and suffix are the same.

    Finally, this function will return true if the string contains only the
    prefix and suffix, like "", "()", "[]", etc. That would mean that an
    empty string is considered wrapped by something.

    @tparam string value
    @tparam string wrapper
    @tparam string endWrapper, optional

    @treturn bool
    ]]
    function Str:isWrappedBy(value, wrapper, endWrapper)
        endWrapper = endWrapper or wrapper

        return
            (value ~= nil) and
            (wrapper ~= nil) and
            (value ~= wrapper) and
            (value:sub(1, #wrapper) == wrapper and value:sub(-#endWrapper) == endWrapper)
    end

    --[[
    Removes quotes from a string.

    This method can't simply call removeWrappers twice for " or ', because
    the string could be wrapped by one type of quote and contain the other
    type inside it, so it first checks which type of quote is wrapping the
    string and then removes it.

    @tparam string value

    @treturn string
    ]]
    function Str:removeQuotes(value)
        if self:isWrappedBy(value, '"') then
            return self:removeWrappers(value, '"')
        end

        return self:removeWrappers(value, "'")
    end

    --[[
    Removes the wrapping strings from a string.

    This function is useful to remove quotes, parentheses, brackets, etc,
    from a string.

    Similarly to Str:isWrappedBy, the third parameter is optional. If it is
    not provided, the function will assume that the prefix and suffix are
    the same.

    @tparam string value
    @tparam string wrapper
    @tparam string endWrapper, optional

    @treturn string
    ]]
    function Str:removeWrappers(value, wrapper, endWrapper)
        return self:isWrappedBy(value, wrapper, endWrapper)
            and value:sub(#wrapper + 1, -#(endWrapper or wrapper) - 1)
            or value
    end

    --[[
    Replaces all occurrences of a substring in a string with another
    substring.

    This function does not support regular expressions. If regular
    expressions are needed, please use Lua's string.gsub function. It was
    created for the convenience of allowing quick replacements that also
    accept characters like ".", "(", "[", etc, that would be interpreted as
    regular expressions metacharacters.

    @tparam string value
    @tparam string find
    @tparam string replace
    ]]
    function Str:replaceAll(value, find, replace)
        return (value:gsub(find:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1"), replace))
    end

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

    --[[
    Removes all whitespace from the beginning and end of a string.

    @tparam string value

    @treturn string
    ]]
    function Str:trim(value)
        return value and value:gsub("^%s*(.-)%s*$", "%1") or value
    end
-- end of Str

self.str = Str