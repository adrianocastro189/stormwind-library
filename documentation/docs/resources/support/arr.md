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

## Methods

* `Arr:get()` - Gets a value in an array using the dot notation.
* `Arr:implode()` - Combines the elements of a table into a single string,
separated by a specified delimiter.
* `Arr:inArray()` - Determines whether a value is in an array.
* `Arr:isArray()` - Determines whether the value is an array indexed by numeric keys or not, by returning false if the table has string keys
* `Arr:map()` - Iterates over the list values and calls the callback
function in the second argument for each of them.
* `Arr:maybeInitialize()` - Initializes a value in a table if it's not 
initialized yet.
* `Arr:set()` - Sets a value in an array using the dot notation.

:::tip Methods args and logic

For more information about valid input for the methods above, please refer
to the `Arr.lua` file itself as it contains a brief explanation over every
method for parameters and the logic behind them.

:::