# Factory

The **Factory** is a simple part of the library responsible for emulating the `new` keyword in OOP languages.

It registers a `new()` method to the library structure that's capable of instantiating classes
that are registered in its `classes` property.

## How to allow classes to be instantiated

These are the steps to allow classes to be instantiated:

1. When writing a Lua file containing a class, make sure to register it by doing
`self.classes['<class name>'] = <class name>` right below the `<class name>.__index = <class name>`
line
1. Write the `__constructor()` method accepting zero or many parameters

Now it's possible to ask the library to provide a new instance of that class with a `new` call.

## Example

Example:

```lua
local MyClass = {}
MyClass.__index = MyClass
self.classes['MyClass'] = MyClass

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