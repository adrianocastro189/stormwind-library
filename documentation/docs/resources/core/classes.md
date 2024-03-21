# Classes

Lua doesn't offer directly a class structure like every
OOP languages like PHP and Java. Because of that, there are
a couple of ways we can emulate classes and effectively be able to
instantiate objects that share logic, property, methods
structure, etc.

The Stormwind Library proposes a few standards to achieve
class structures that are created with a couple of metatables
settings and some indentation.

## Class standards

These are the standards used by Stormwind Library for a table to be
considered a class:

* Each class is defined in its own file, which is later merged to the
single library file
* All lines below the first `local` declaration are indented as
they belong to an opened structure
* Classes have a constructor similar to PHP's, called `__construct()`
* Due to how the library is compiled, when this "class" is being read by
the Lua compiler, the `self` calls are actually referencing the Library
instance, not the class being written -- **only the `self`'s inside
methods refer to the "class" itself**, and because of that, a `self:addClass()`
is called at the top, so the library can store a reference for this "class",
declared as `local`. After that, the library can instantiate that class
anywhere in the addon code.
    * Read the [factory documentation](factory) for more information

## Class recipe

Use the recipe below to create new models.

This is an example of a simple class with a property called `name` and
a simple method.

```lua
--[[
Class description.
]]
local ClassName = {}
    ClassName.__index = ClassName
    ClassName.__ = self
    self:addClass('ClassName', ClassName)

    --[[
    ClassName constructor.

    @tparam string name the ClassName's name
    ]]
    function ClassName.__construct(name)
        local self = setmetatable({}, ClassName)

        self.name = name

        return self
    end

    --[[
    Function description

    @treturn boolean
    ]]
    function ClassName:modelFunction()
        return 'something'
    end
-- end of ClassName
```
