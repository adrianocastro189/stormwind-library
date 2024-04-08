--[[--
The Bool support class contains helper functions to manipulate boolean
values.

@classmod Bool

@usage
    -- library is an instance of the Stormwind Library
    library.bool
]]
local Bool = {}
    Bool.__index = Bool
    Bool.__ = self

    --[[--
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

    @tparam integer|string|boolean value the value to be checked

    @treturn boolean whether the value represents a true value or not

    @usage
        -- library is an instance of the Stormwind Library
        library.bool:isTrue("yes") -- true
        library.bool:isTrue("no")  -- false
        library.bool:isTrue("1")   -- true
        library.bool:isTrue("0")   -- false
        library.bool:isTrue(1)     -- true
        library.bool:isTrue(0)     -- false
        library.bool:isTrue(true)  -- true
        library.bool:isTrue(false) -- false
    ]]
    function Bool:isTrue(value)
        local inArray, index = self.__.arr:inArray({1, "1", "true", true, "yes"}, value)

        -- it returns just the first inArray result, as the second value is the index
        -- which makes no sense in this context
        return inArray
    end
-- end of Bool

self.bool = Bool