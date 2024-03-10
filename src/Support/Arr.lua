--[[
The Arr support class contains helper functions to manipulate arrays.
]]
local Arr = {}
Arr.__index = Arr
Arr.__ = self

--[[
Gets a value in an array using the dot notation.

With the dot notation search, it's possible to query a value in a multidimensional array
by passing a single string containing keys separated by dot.
]]
function Arr:get(list, key, default)
    local keys = self.__.str:split(key, '.')
    local current = list[keys[1]]

    for i = 2, #keys do current = current and current[keys[i]] or nil end

    return current or default
end

--[[
Combines the elements of a table into a single string, separated by a
specified delimiter.

@tparam string the delimiter used to separate the elements in the resulting string
@tparam array the table containing elements to be combined into a string

@treturn string
]]
function Arr:implode(delimiter, list)
    if not (self:isArray(list)) then
        return list
    end

    local result = ""
    local length = #list
    for i, v in ipairs(list) do
        result = result .. v
        if i < length then
            result = result .. delimiter
        end
    end
    return result
end

--[[
Determines whether the value is an array or not.

The function checks whether the parameter passed is a table in Lua.
If it is, it iterates over the table's key-value pairs, examining each key
to determine if it is numeric. If all keys are numeric, indicating an
array-like structure, the function returns true; otherwise, it returns
false.

This strategy leverages Lua's type checking and table iteration
capabilities to ascertain whether the input value qualifies as an array.

@return boolean
]]
function Arr:isArray(value)
    if type(value) == "table" then
        local isArray = true
        for k, v in pairs(value) do
            if type(k) ~= "number" then
                isArray = false
                break
            end
        end
        return isArray
    end
    return false
end

--[[
Iterates over the list values and calls the callback function in the second
argument for each of them.

The callback function must be a function that accepts (val) or (val, i)
where val is the object in the interaction and i it's index.

This method accepts arrays and tables.
]]
function Arr:map(list, callback)
    local results = {}

    for i, val in pairs(list) do results[i] = callback(val, i) end

    return results
end

--[[
Initializes a value in a table if it's not initialized yet.

The key accepts a dot notation key just like get() and set().
]]
function Arr:maybeInitialize(list, key, initialValue)
    if self:get(list, key) == nil then self:set(list, key, initialValue) end
end

--[[
Sets a value using arrays dot notation.

It will basically iterate over the keys separated by "." and create
the missing indexes, finally setting the last key with the value in
the args list.
]]
function Arr:set(list, key, value)
    local keys = self.__.str:split(key, '.')
    local current = list

    for i = 1, #keys do
        local key = keys[i]

        if i == #keys then
            -- this is the last key, so just the value and return
            current[key] = value
            return
        end

        -- creates an empty table
        if current[key] == nil then current[key] = {} end
        
        -- sets the "pointer" for the next iteration
        current = current[key]
    end
end

self.arr = Arr