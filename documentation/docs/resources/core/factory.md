import React from 'react';
import YouTubeEmbed from '@site/src/components/YouTubeEmbed';

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
   * After version 1.6.0, a new parameter was introduced to allow the 
     registration of abstract classes by using the new `library.classTypes`
     constants
       * `CLASS_TYPE_ABSTRACT` for abstract classes
       * `CLASS_TYPE_CONCRETE` for concrete classes that can be instantiated,
         which is also the default value when omitted
1. Write the `__constructor()` method accepting zero or many parameters

With that, it's possible to ask the library to provide a new instance of that 
class with a `new` call.

<YouTubeEmbed videoId="KRL30brxHLU" />

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

It's possible to extend classes when inheriting their table structures by 
getting the class structure with `getClass()` and then setting the metatable of 
the new class with the parent class structure.

If using the library version 1.6.0 or newer, it's also possible to use a helper
method called `extend()` that expects a table structure and the parent class 
name.

This method will set the child class metatable with the parent class structure
but be warned that it won't add the class to be instantiated automatically. The 
reason for that is that `addClass()` can also be used to add abstract classes,
so `extend()` can't determine if the child class should be instantiable or not.

To save code repetition when extending classes, it's also possible to use the
`addChildClass()` method, which will extend the class and add it to the list of
classes handled by the library. This method will also respect the client flavors
if provided, just like for the `addClass()` method, and also be able to add
abstract child classes, as long as passing the correct class type constant.

Example:

```lua
local MyParentClass = {}
MyParentClass.__index = MyParentClass
-- constructor omitted for brevity in this example
library:addClass('MyParentClass', MyParentClass)

local MyChildClass = {}
MyChildClass.__index = MyChildClass
-- constructor omitted for brevity in this example

-- extend the class with...
library:extend(MyChildClass, 'MyParentClass')
library:addClass('MyChildClass', MyChildClass)
-- ...or
library:addChildClass('MyChildClass', MyChildClass, 'MyParentClass')
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