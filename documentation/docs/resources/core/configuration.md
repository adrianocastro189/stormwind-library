# Configuration

The Configuration class provides methods to easily access and manipulate the 
configuration properties. That reduces the need to pollute the addon code 
with sanity checks, index initializations, etc.

Along with the Configuration class, the library provides a proxy method called
`config(...)` that allows the addon to access the configuration properties in 
a more readable way.

That way, addons can access configuration properties without touching the
saved variables directly, making the code more readable and maintainable.

:::tip Configuration and settings

Be aware the configurations are not the same as settings.

Configurations can be values that are not meant to be changed by the user,
like constants, or values that are set by the addon itself.

Settings are a **subset** of configurations that are meant to be changed by 
the user. That said, the Configuration class is also used to handle the 
settings if the addon developer wants to.

:::

## Creating a configuration

To create a new configuration instance, it's required to pass a table to its
constructor. This can be any table, persistent or not, that will be used to
store the configuration properties. However, it's highly recommended to use
the **saved variables table** to store the configuration properties.

After that, the addon can access the configuration properties using the 
Configuration setters and getters.

**Note:** For a detailed explanation of the Configuration accessors, read the
[technical documentation](../../library-structure/luadocs#generated-docs).

```lua
local configTable = {}

local config = library:new('Configuration', configTable)

-- now, any configuration property is set or retrieved using the config
-- instance that will affect the configTable instance
```

The example above works for any table, but as mentioned, it's recommended to
pass the saved variables table to the Configuration constructor, that way, 
when a configuration or setting is changed, it will be automatically saved
when the game is closed or reloaded.

So, based on the TOC file below...

```toc
## Author: ...
## Interface: ...
## SavedVariables: MyAddon_Data
## ...
```

...this is how the configuration instance should be created:

```lua
local config = library:new('Configuration', MyAddon_Data)
```

## Accessing the configuration

The Configuration class offers a set of methods to access the configuration
properties. Those are better explained in the [technical documentation](../../library-structure/luadocs#generated-docs)
and should be used only if the addon needs to have multiple configurations
tables.

In most of the cases, when the addon has only one configuration table, the
**library will automatically instantiate the Configuration class** and make it
available through the `config(...)` proxy method.

To achieve that, the addon must pass the saved variables table name to the
[library properties](../../resources/core/addon-properties.md) with the `data`
key.

```lua
local __ = StormwindLibrary.new({
  -- colors = {
    -- primary = '...'
  --},
  -- command = 'mycommand',
  -- name = 'MyAddon'
  data = 'MyAddon_Data'
})
```

After that, the `config(...)` method will be available to access the
configuration properties in the following combination of parameters:

1. `config('dot.notation.key')` - retrieves the value of the key or `nil` if
the key is not found
1. `config('dot.notation.key', defaultValue)` - retrieves the value of the key
or the default value if the key is not found
1. `config('dot.notation.key', defaultValue, true)` - retrieves the value of 
the key; **or** sets the default value if the key is not found, returning it
after that
1. `config({['property.a'] = 'value', ['property.b'] = 'value'})` - sets the
values of the keys in the table

Examples:

```lua
-- addon data stored as MyAddon_Data
MyAddon_Data = {
  property = {
    a = 'value-a',
    b = 'value-b'
  }
}

-- returns 'value-a'
library:config('property.a')

-- returns 'value-c', but the key is not added
library:config('property.c', 'value-c')

-- returns 'value-c' and adds the new key
library:config('property.c', 'value-c', true)

-- this is the data after the last call
MyAddon_Data = {
  property = {
    a = 'value-a',
    b = 'value-b',
    c = 'value-c'
  }
}

-- sets the new values
library:config({
  ['property.a'] = 'new-value-a',
  ['property.b'] = 'new-value-b'
})

-- this is the data after the last call
MyAddon_Data = {
  property = {
    a = 'new-value-a',
    b = 'new-value-b',
    c = 'value-c'
  }
}
```

## Setting a prefix key

When creating a new configuration instance, it's possible to set a prefix key
that will be used to prefix all the keys in the configuration table.

This is useful when the addon needs to have same configurations for multiple
contexts, like different profiles, characters, etc.

The prefix can be anything, even a dot notation string, **as long as it 
doesn't end with a dot**, considering that the prefix will be placed before
any keys being accessed separately by a dot.

If no prefix is set, the Configuration class will not prefix the keys, and
that's the default state of this class.

```lua
local config = library:new('Configuration', MyAddonData)

-- this will try to access the key 'property.a' in the MyAddonData table
config('property.a')

-- setting a prefix key
config:setPrefix('any.prefix')

-- after the prefix is set, calling...
config('property.a')

-- ...will have the configuration instance trying to access the key
-- 'any.prefix.property.a' in the MyAddonData table
-- MyAddonData['any']['prefix']['property']['a']
```

:::warning Default configuration instance

The library default configuration instance **doesn't have a prefix key**. That
means the `config(...)` method will try to access the keys directly in the
saved variables table and considered as a way to access **global** 
configuration values, regardless of players, realms, etc.

Of course, by **global** it means the saved variables table itself, not the
global environment. It's global in the addon context.

:::