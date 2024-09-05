--[[--
The Str support class contains helper functions to manipulate strings.

@classmod Support.Str

@usage
    -- library is an instance of the Stormwind Library
    library.str
]]
local Str = {}
    Str.__index = Str

    --[[--
    Determines whether a string is empty or not.

    By empty, it means that the string is nil, has no characters, or has only
    whitespace characters. This last case is important because a string with
    only whitespace characters is not considered empty by Lua's standards,
    but it is by this function's standards.

    If a method shouldn't consider a string with only whitespace characters
    as empty, please do not use this function.
        
    @tparam string value the string to be checked

    @treturn boolean whether the string is empty or not

    @usage
        local value = "  "
        library.str:isEmpty(value) -- true
    ]]
    function Str:isEmpty(value)
        return value == nil or (string.len(self:trim(value)) == 0)
    end

    --[[--
    Determines whether a string is not empty.

    This function is the opposite of Str:isEmpty.

    @tparam string value the string to be checked

    @treturn boolean whether the string is not empty

    @usage
        local value = "  "
        library.str:isNotEmpty(value) -- false
    ]]
    function Str:isNotEmpty(value)
        return not self:isEmpty(value)
    end

    --[[--
    Determines whether a string is quoted by " or '.

    @tparam string value the string to be checked

    @treturn boolean whether the string is quoted or not

    @usage
        local value = "'quoted'"
        library.str:isQuoted(value) -- true
    ]]
    function Str:isQuoted(value)
        return self:isWrappedBy(value, '"') or self:isWrappedBy(value, "'")
    end

    --[[--
    Determines whether a string is wrapped by a prefix and a suffix.

    This function is useful to determine if a string is wrapped by a pair of
    strings, like quotes, parentheses, brackets, etc.

    The third parameter is optional. If it is not provided, the function will
    assume that the prefix and suffix are the same.

    Finally, this function will return true if the string contains only the
    prefix and suffix, like "", "()", "[]", etc. That would mean that an
    empty string is considered wrapped by something.

    @tparam string value the string to be checked
    @tparam string wrapper the prefix of the wrapping
    @tparam ?string endWrapper the suffix of the wrapping, will assume
                    wrapper if not provided

    @treturn boolean whether the string is wrapped by the prefix and suffix

    @usage
        local value = "'quoted'"
        library.str:isWrappedBy(value, "'") -- true
    ]]
    function Str:isWrappedBy(value, wrapper, endWrapper)
        endWrapper = endWrapper or wrapper

        return
            (value ~= nil) and
            (wrapper ~= nil) and
            (value ~= wrapper) and
            (value:sub(1, #wrapper) == wrapper and value:sub(-#endWrapper) == endWrapper)
    end

    --[[--
    Removes quotes from a string.

    This method can't simply call removeWrappers twice for " or ', because
    the string could be wrapped by one type of quote and contain the other
    type inside it, so it first checks which type of quote is wrapping the
    string and then removes it.

    @tparam string value the string to be checked

    @treturn string the string without quotes

    @usage
        local value = "'quoted'"
        library.str:removeQuotes(value) -- quoted
    ]]
    function Str:removeQuotes(value)
        if self:isWrappedBy(value, '"') then
            return self:removeWrappers(value, '"')
        end

        return self:removeWrappers(value, "'")
    end

    --[[--
    Removes the wrapping strings from a string.

    This function is useful to remove quotes, parentheses, brackets, etc,
    from a string.

    Similarly to Str:isWrappedBy, the third parameter is optional. If it is
    not provided, the function will assume that the prefix and suffix are
    the same.

    @tparam string value the string to be checked
    @tparam string wrapper the prefix of the wrapping
    @tparam ?string endWrapper the suffix of the wrapping, will assume
                wrapper if not provided

    @treturn string the string without the prefix and suffix

    @usage
        local value = "'quoted'"
        library.str:removeWrappers(value, "'") -- quoted
    ]]
    function Str:removeWrappers(value, wrapper, endWrapper)
        return self:isWrappedBy(value, wrapper, endWrapper)
            and value:sub(#wrapper + 1, -#(endWrapper or wrapper) - 1)
            or value
    end

    --[[--
    Replaces all occurrences of a substring in a string with another
    substring.

    This function does not support regular expressions. If regular
    expressions are needed, please use Lua's string.gsub function. It was
    created for the convenience of allowing quick replacements that also
    accept characters like ".", "(", "[", etc, that would be interpreted as
    regular expressions metacharacters.

    @tparam string value the subject string to have the replacements
    @tparam string find the substring to be replaced
    @tparam string replace the substring to replace the find substring

    @treturn string the string after the replacements

    @usage
        local value = "Hello, world!"
        library.str:replaceAll(value, "world", "Lua") -- Hello, Lua!
    ]]
    function Str:replaceAll(value, find, replace)
        return (value:gsub(find:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1"), replace))
    end

    --[[--
    Splits a string in a table by breaking it where the separator is found.

    @tparam string value the string to be split
    @tparam string separator the separator to split the string

    @treturn table a table with the split strings

    @usage
        local value = "Hello, world!"
        library.str:split(value, ", ") -- { "Hello", "world!" }
    ]]
    function Str:split(value, separator)
        local values = {}
        for str in string.gmatch(value, "([^"..separator.."]+)") do
            table.insert(values, str)
        end
        return values
    end

    --[[--
    Removes all whitespace from the beginning and end of a string.

    @tparam string value the string to be trimmed

    @treturn string the string without whitespace at the beginning and end

    @usage
        local value = "  Hello, world!  "
        library.str:trim(value) -- "Hello, world!"
    ]]
    function Str:trim(value)
        return value and value:gsub("^%s*(.-)%s*$", "%1") or value
    end

    --[[--
    Returns the given string with the first character capitalized.

    @NOTE: This function may not work properly if the string starts with a special
           character, like an accent, because it uses Lua's default implementations
           for sub and upper functions. It should be used with caution and better
           when the string is known to start with a letter. Future implementations
           may improve this behavior if needed.

    @tparam string value The string to have the first character capitalized

    @treturn string The string with the first character capitalized

    @usage
        local value = "hello, world!"
        library.str:ucFirst(value) -- "Hello, world!"
    ]]
    function Str:ucFirst(value)
        return value:sub(1, 1):upper() .. value:sub(2)
    end
-- end of Str

self.str = Str