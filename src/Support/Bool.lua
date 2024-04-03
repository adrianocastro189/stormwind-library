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

    @NOTE: Developers may notice this class has no isFalse() method.
           In terms of determining if a value is true, there's a limited
           range of values that can be considered true. On the other hand,
           anything else shouldn't be considered false. Consumers of this
           class can use isTrue() to determine if a value represents a true
           value, but using a isFalse() method would be a bit inconsistent.
           That said, instead of having a isFalse() method, consumers can
           use the not operator to determine if a value is false, which
           makes the code more readable, like: if this value is not true,
           then do something.

    @tparam mixed value

    @treturn bool
    ]]
    function Bool:isTrue(value)
        -- it returns just the first inArray result, as the second value is the index
        -- which makes no sense in this context
        return self.__.arr:inArray({1, "1", "true", true, "yes"}, value)[1]
    end
-- end of Bool

self.bool = Bool