# Factory

**Factory** is a simple part of the library responsible for emulating the `new` 
keyword from OOP languages.

It registers a `new()` method to the library structure that's capable of 
instantiating classes that are registered in its `classes` property.

:::warning Model factories are not covered here

Please, refer to the [factories](/docs/category/factories) documentation for information about model factories, which are a different concept from this one.

:::

## How to allow classes to be instantiated

These are the steps to allow [classes](classes) to be instantiated:

1. When writing a Lua file containing a class, make sure to register it by doing
`self:addClass('<class name>', <class table>)` right below the `<class name>.__index = <class table>`
line
   * It's also possible to limit the class instantiation per World of Warcraft
     version by adding a third parameter to this call, which is a string or 
     table representing one or many [client flavors](environment)
   * When no flavors are provided, the class is instantiable in any World of 
     Warcraft version
1. Write the `__constructor()` method accepting zero or many parameters

With that, it's possible to ask the library to provide a new instance of that 
class with a `new` call.

## Examples

Adding a class that's instantiable in any World of Warcraft version:

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

Adding a class that's instantiable only in Classic Era

```lua
local MyClassicEraClass = {}
MyClassicEraClass.__index = MyClassicEraClass
self:addClass('MyClassicEraClass', MyClassicEraClass, library.environment.constants.CLIENT_CLASSIC_ERA)

function MyClassicEraClass.__construct()
    -- ...
end
```

Now, it's possible to instantiate `MyClass` in any World of Warcraft version 
by doing a `new()` call in the library instance, but `MyClassicEraClass` can
only be instantiated if running a World of Warcraft Classic Era client, like 
in Season of Discovery, Hardcore, etc.

```lua
-- this will work in any World of Warcraft version
local instance = library:new('MyClass', 'Any name')

-- this will throw an error if running in a non-Classic Era client
local instance = library:new('MyClassicEraClass')
```

## Class inheritance

To allow class inheritance, instead of calling the `new()` method directly, 
it's possible to retrieve a class structure with the `getClass()` method. That
way, a class can inherit another one by using any inheritance strategy, like 
setting the meta table.

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

## Abstract classes

[Stormwind Library v1.6.0](../../changelog) introduced the concept of abstract 
classes to its Factory by allowing the registration of classes that can't be 
instantiated with the `new()` method. This is useful for creating classes that 
are meant to be used as a base for other classes with abstractions and methods 
that should be implemented by child classes.

To register an abstract class, use the `addAbstractClass()` method instead of
`addClass()`. With that, the `new()` method won't be able to instantiate that
class.

```lua
local MyAbstractClass = {}
MyAbstractClass.__index = MyAbstractClass
self:addAbstractClass('MyAbstractClass', MyAbstractClass)
```