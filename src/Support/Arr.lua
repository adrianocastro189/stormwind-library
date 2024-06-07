--[[--
The Arr class contains helper functions to manipulate arrays.

@classmod Support.Arr

@usage
    -- library is an instance of the Stormwind Library
    library.arr
]]
local Arr = {}
    Arr.__index = Arr
    Arr.__ = self

    --[[
    Iterates over the list values and calls a callback function for each of
    them, returning true if at least one of the calls returns true.

    Once the callback returns true, the method stops the iteration and
    returns, which means that the callback won't be called for the remaining
    items in the list.

    The callback function must be a function that accepts (val) or (val, i)
    where val is the object in the interaction and i it's index. It also must
    return a boolean value.

    @tparam table list The list to be iterated
    @tparam function callback The function to be called for each item in the list
    
    @treturn boolean Whether the callback returned true for at least one item
    ]]
    function Arr:any(list, callback)
        for i, val in pairs(list or {}) do
            if callback(val, i) then
                return true
            end
        end

        return false
    end

    --[[--
    Concatenates the values of the arrays passed as arguments into a single
    array.

    This method should be called only for arrays, as it won't consider table
    keys and will only concatenate their values.

    @tparam table ... The arrays to be concatenated

    @treturn table The concatenated array

    @usage
        local list1 = {1, 2}
        local list2 = {3, 4}
        local results = library.arr:concat(list1, list2)
        -- results = {1, 2, 3, 4}
    ]]
    function Arr:concat(...)
        local results = {}
        self:each({...}, function(list)
            self:each(list, function(value)
                table.insert(results, value)
            end)
        end)
        return results
    end

    --[[--
    Iterates over the list values and calls the callback function in the
    second argument for each of them.

    The callback function must be a function that accepts (val) or (val, i)
    where val is the object in the interaction and i it's index.

    This method accepts arrays and tables.

    If you need to store the results of the callback, use the Arr:map() method.

    @see Arr.map

    @tparam table list the list to be iterated
    @tparam function callback the function to be called for each item in the list

    @usage
        local list = {1, 2, 3}
        local results = library.arr:map(list, function(val) print(val * 2) end)
    ]]
    function Arr:each(list, callback)
        for i, val in pairs(list) do callback(val, i) end
    end

    --[[--
    Freezes a table, making it immutable.

    This method is useful when you want to create a constant table that
    can't be changed after its creation, considering that Lua doesn't have
    a native way to define constants.

    The implementation below was inspired by the following article:
    https://andrejs-cainikovs.blogspot.com/2009/05/lua-constants.html

    @tparam table table the table to be frozen

    @treturn table the frozen table

    @usage
        local table = {a = 1}
        local frozen = library.arr:freeze(table)
        frozen.a = 2
        -- error: a is a constant and can't be changed
    ]]
    function Arr:freeze(table)
        return setmetatable({}, {
            __index = table,
            __newindex = function(t, key, value)
                error(key .. " is a constant and can't be changed", 2)
            end
        })
    end

    --[[--
    Gets a value in an array using the dot notation.
    
    With the dot notation search, it's possible to query a value in a
    multidimensional array by passing a single string containing keys
    separated by dot.
    
    @tparam table list the table containing the value to be retrieved
    @tparam string key a dot notation key to be used in the search
    @tparam ?any default the default value to be returned if the key is not found
    
    @treturn any|nil

    @usage
        local list = {a = {b = {c = 1}}}
        local value = library.arr:get(list, 'a.b.c')
        -- value = 1
    ]]
    function Arr:get(list, key, default)
        local keys = self.__.str:split(key, '.')
        local current = list
    
        for i = 1, #keys do
            current = current and current[keys[i]]
            if current == nil then
                return default
            end
        end
    
        return current
    end

    --[[--
    Combines the elements of a table into a single string, separated by
    a specified delimiter.
    
    @tparam string delimiter the delimiter used to separate the elements in the resulting string
    @tparam table list the table containing elements to be combined into a string
    
    @treturn string

    @usage
        local list = {1, 2, 3}
        local combined = library.arr:implode(', ', list)
        -- combined = '1, 2, 3'
    ]]
    function Arr:implode(delimiter, list)
        if not (self:isArray(list)) then
            return list
        end

        return table.concat(list, delimiter)
    end

    --[[--
    Determines whether a value is in an array.

    If so, returns true and the index, false and 0 otherwise.

    Class instances can also be checked in this method, not only primitive
    types, as long as they implement the __eq method.

    @tparam table list the array to be checked
    @tparam any value the value to be checked

    @treturn[1] boolean whether the value is in the array
    @treturn[1] integer the index of the value in the array

    @usage
        local list = {'a', 'b', 'c'}
        local found, index = library.arr:inArray(list, 'b')
        -- found = true, index = 2
    ]]
    function Arr:inArray(list, value)
        for i, val in pairs(list) do
            if val == value then
                return true, i
            end
        end

        return false, 0
    end

    --[[--
    Inserts a value in an array if it's not in the array yet.

    It's important to mention that this method only works for arrays with
    numeric indexes. After all, if using string keys, there's no need to check,
    but only setting and replacing the value.

    Class instances can also be passed as the value, not only primitive types,
    as long as they implement the __eq method.

    @tparam table list the array to have the value inserted
    @tparam any value the value to be inserted

    @treturn boolean whether the value was inserted or not

    @usage
        local list = {'a', 'b'}
        local inserted = library.arr:insertNotInArray(list, 'c')
        -- list = {'a', 'b', 'c'}, inserted = true
    ]]
    function Arr:insertNotInArray(list, value)
        if not self:isArray(list) or self:inArray(list, value) then
            return false
        end

        table.insert(list, value)
        return true
    end

    --[[--
    Determines whether the value is an array or not.

    The function checks whether the parameter passed is a table in Lua.
    If it is, it iterates over the table's key-value pairs, examining each key
    to determine if it is numeric. If all keys are numeric, indicating an
    array-like structure, the function returns true; otherwise, it returns
    false.

    This strategy leverages Lua's type checking and table iteration
    capabilities to ascertain whether the input value qualifies as an array.

    @tparam any value the value to be checked

    @return boolean

    @usage
        local value = {1, 2, 3}
        local isArray = library.arr:isArray(value)
        -- isArray = true

        value = {a = 1, b = 2, c = 3}
        isArray = library.arr:isArray(value)
        -- isArray = false
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

    --[[--
    Iterates over the list values and calls the callback function in the
    second argument for each of them, storing the results in a new list to
    be returned.

    The callback function must be a function that accepts (val) or (val, i)
    where val is the object in the interaction and i it's index.

    This method accepts arrays and tables.

    @tparam table list the list to be iterated
    @tparam function callback the function to be called for each item in the list

    @treturn table the list with the callback results

    @usage
        local list = {1, 2, 3}
        local results = library.arr:map(list, function(val) return val * 2 end)
        -- results = {2, 4, 6}
    ]]
    function Arr:map(list, callback)
        local results = {}

        for i, val in pairs(list) do results[i] = callback(val, i) end

        return results
    end

    --[[--
    Initializes a value in a table if it's not initialized yet.

    The key accepts a dot notation key just like get() and set().

    @tparam table list the table to have the value initialized
    @tparam string key the key to be initialized
    @tparam any initialValue the value to be set if the key is not initialized

    @usage
        local list = {}
        library.arr:maybeInitialize(list, 'a.b.c', 1)
        -- list = {a = {b = {c = 1}}}
    ]]
    function Arr:maybeInitialize(list, key, initialValue)
        if self:get(list, key) == nil then self:set(list, key, initialValue) end
    end

    --[[--
    Extracts a list of values from a list of objects based on a given key.

    It's important to mention that nil values won't be returned in the
    resulted list. Which means: objects that have no property or when their
    properties are nil, the values won't be returned. That said, a list with n
    items can return a smaller list.

    The key accepts a dot notation key just like get() and set().

    @tparam table list the list of objects to have the values extracted
    @tparam string key the key to be extracted from the objects

    @treturn table the list of values extracted from the objects

    @usage
        local list = {{a = 1}, {a = 2}, {a = 3}}
        local values = library.arr:pluck(list, 'a')
        -- values = {1, 2, 3}
    ]]
    function Arr:pluck(list, key)
        local results = {}
        for _, item in ipairs(list) do
            table.insert(results, self:get(item, key))
        end
        return results
    end

    --[[--
    Removes a value from an indexed array.

    Tables with non numeric keys won't be affected by this method.

    The value must be the value to be removed and not the index.

    @tparam table list the array to have the value removed
    @tparam any value the value to be removed

    @treturn boolean whether the value was removed or not

    @usage
        local list = {1, 2, 3}
        local removed = library.arr:remove(list, 2)
        -- list = {1, 3}, removed = true
    ]]
    function Arr:remove(list, value)
        if not self:isArray(list) then return false end

        local found, index = self:inArray(list, value)

        if not found then return false end

        table.remove(list, index)
        return true
    end

    --[[--
    Sets a value using arrays dot notation.

    It will basically iterate over the keys separated by "." and create
    the missing indexes, finally setting the last key with the value in
    the args list.

    @tparam table list the table to have the value set
    @tparam string key the key to be set
    @tparam any value the value to be set

    @usage
        local list = {}
        library.arr:set(list, 'a.b.c', 1)
        -- list is now {a = {b = {c = 1}}}
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

    --[[--
    Calls the available unpack() method given the running environment.

    This method is an important helper because World of Warcraft supports
    the unpack() function but not table.unpack(). At the same time, some
    Lua installations have no unpack() but table.unpack().

    @codeCoverageIgnore this method is just a facade to the proper unpack
                        method and won't be tested given that it's tied to
                        the running environment

    @tparam table list the list to be unpacked
    @tparam ?integer i the initial index
    @tparam ?integer j the final index

    @treturn any...

    @usage
        local list = {1, 2, 3}
        local a, b, c = library.arr:unpack(list)
        -- a = 1, b = 2, c = 3
    ]]
    function Arr:unpack(list, i, j)
        if unpack then return unpack(list, i, j) end

        return table.unpack(list, i, j)
    end

    --[[--
    Wraps a value in a table.

    This method is very useful for methods that accept objects and arrays
    on the same variable. That way, they don't need to check the type, but
    wrap it and work with an array.

    If the value provided is a table, this method won't result in a
    bidimensional table, but will return the table itself.

    @tparam any value the value to be wrapped

    @treturn table

    @usage
        local value = 1
        local wrapped = library.arr:wrap(value)
        -- wrapped = {1}
    ]]
    function Arr:wrap(value)
        if type(value) == 'table' then return value end

        return {value}
    end
-- end of Arr

self.arr = Arr