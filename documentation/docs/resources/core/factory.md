# Factory

The **Factory** is a simple part of the library responsible for emulating the `new` keyword in OOP languages.

It registers a `new()` method to the library structure that's capable of instantiating classes
that are registered in its `classes` property.

## How to allow classes to be instantiated

These are the steps to allow classes to be instantiated:

1. When writing a Lua file containing a class, make sure to register it by doing
`self:addClass('<class name>', <class name>)` right below the `<class name>.__index = <class name>`
line
1. Write the `__constructor()` method accepting zero or many parameters

Now it's possible to ask the library to provide a new instance of that class with a `new` call.

## Example

Example:

```lua
local MyClass = {}
MyClass.__index = MyClass
self:addClass('MyClass', MyClass)

function MyClass.__construct(name)
    local self = setmetatable({}, MyClass)

    self.name = name

    return self
end
```

Now, it's possible to instantiate `MyClass` with:

```lua
-- stormwindLibrary is the library instance created in an addon
local instance = stormwindLibrary:new('MyClass', 'Any name')
```

## Class inheritance

To allow class inheritance, instead of calling the `new()` method directly, 
it's possible to retrieve a class structure with the `getClass()` method. That
way, a class can inherit another one by using any inheritance strategy, like setting the meta table.

Example:

```lua
-- imagine that this is a class in the library or in another addon
local MyClass = {}
MyClass.__index = MyClass
self:addClass('MyClass', MyClass)

-- then to inherit from MyClass, get the class structure with:
myClassStructure = library:getClass('MyClass')
-- and then inherit from it using your preferred way to work with inheritance
-- in Lua, like the setmetatable function
setmetatable(MyNewClass, myClassStructure)
```

:::warning Parent class constructor limitations

Due to how class instantiation works in the Stormwind Library, the parent 
class constructor can be a bit tricky to call. The best way to do it is to
not use this structure if you need that or override the `__construct()` method
in the child class by doing the same thing as the parent class constructor.

:::