--[[
The Bool support class contains helper functions to manipulate boolean
values.
]]
local Bool = {}
    Bool.__index = Bool
    Bool.__ = self

    --[[
    Determines whether a value represents true or not.

    This method checks if a value is in a range of possible values that
    represent a true value.

    @tparam mixed value

    @treturn bool
    ]]
    function Bool:isTrue(value)
        return self.__.arr:inArray({1, "1", "true", true, "yes"}, value)
    end
-- end of Bool

self.bool = Bool