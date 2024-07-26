# Arr

The **Arr** methods are focused on manipulating arrays.

This class was inspired by the PHP Laravel's class and attempts to provide
similar resources to work with arrays. Of course, Lua tables and PHP arrays
are different things, but from a development standpoint, they can work 
similarly.

**Arr** methods are tested by `tests\Support\ArrTest.lua`.

## Dot notation keys

Some **Arr** methods accept dot notation keys, which are keys condensed in 
a string that are interpreted as nested keys. In World of Warcraft, addon 
data is usually stored in tables that and their values are retrieved from 
nested tables.

The dot notation comes in handy to improve readness and also avoid 
repetitive loops.

Here's an example of how dot notation keys work. Imagine a list created 
with the following nested lists:

```lua
local list = {}
list['root'] = {}

list['root']['level1-a'] = {}
list['root']['level1-b'] = {}
list['root']['level1-c'] = {}

list['root']['level1-a']['level2'] = 'some-value'
```

In order to get the last level value, a `list['root']['level1-a']['level2']`
call is made, that could also throw errors if any of the indexes don't 
exist.

With `Arr:get()` it's possible to run:

```lua
local value = Arr:get(list, 'root.level1-a.level2', 'default-value')
```

The code above will return the nested value **OR** the default value passed 
as the third argument. If no default value is provided, `nil` will be 
returned, but the most important thing here is that no errors will be throw
by accessing invalid properties inside a table.

On the other hand, `Arr:set()` can create those levels with a single line, 
with no need to iterate over the table and create the indexes that aren't
created yet.

```lua
Arr:set(list, 'root.level1-b.level2', 'another-value')
```

The code above is the same as doing `list['root']['level1-b']['level2']`,
however, if `root` or `level1-b` are `nil`, they'll be created as `{}` until
reaching the last key.

:::warning Careful with dot notation keys containing numbers

When retrieving values from a table using dot notation keys, it's possible to
use numbers as keys. Methods like `Arr:get()` and `Arr:hasKey()` plus others
that don't set values, will be able to return a value whether the key is a
number or a string.

As an example, calling `Arr:get()` with the following tables...

```lua
local listA = {['a'] = {['1'] = 'value'}}
local listB = {['a'] = {'value'}}
```

...will return the same value when passing `'a.1'` as the key.

**However**, when setting values with `Arr:set()`, the keys will always be
considered a string. So when calling `Arr:set(list, 'a.1', 'value')`, the
result will be:

```lua
local list = {['a'] = {['1'] = 'value'}}
```

That's the behavior adopted to avoid questions about the type of the keys,
considering that when retrieving, the library can check both types and return 
the value, but when setting, it's not possible to imagine what's the intention 
of the developer.

As a final note, for edge cases where a table contains both a string and the 
same number as keys, `Arr:get()` will return the value of the string key.

```lua
local list = {['a'] = {'another-value', ['1'] = 'value'}}

-- return will be 'value'
Arr:get(list, 'a.1')
```

:::

## Creating constants

Lua doesn't have a native way to create constants, but it's possible to
mimic this behavior by using tables and metatables.

The `Arr:freeze()` method is a helper to create a table with read-only
properties. And that's achieved by setting a metatable that will throw an
error when trying to set a new value to the table.

Here's an example of how to create a constant table:

```lua
local constants = Arr:freeze({
    MY_CONSTANT_NAME = 'my-constant-value',
})

-- this will print 'my-constant-value'
print(constants.MY_CONSTANT_NAME)

-- this will throw an error
constants.MY_CONSTANT_NAME = 'new-value'
```

:::tip Prefer to use tables named `constants`

In a programming language that supports constants, it's common to declare
them in uppercase at the beginning of a class. At the same time, with the 
freeze function it's possible to have multiple constant tables anywhere.

In Stormwind Library, it's considered a good practice to group all constants 
in a table called `constants` right after a [class](../core/classes.md) 
declaration, even if the constants are not totally related with each other.

Using this as a convention, Stormwind Library can provide a similar 
experience and making it clear that the table is a list of constants.

:::

## Methods

Please, refer to the [technical documentation](pathname:///lua-docs/classes/Support.Arr.html)
to get more information about this class and its methods.