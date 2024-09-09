# Settings

Settings are basically [configuration](configuration) values that can be manipulated
by players with chat commands and UI elements.

It's important to note that the configuration structure is a base for this class as 
it is used to store the settings values for global and player scopes. The reason 
they're separated in two classes is to avoid confusion and handle settings properly.

A good example of the difference between the two: an addon that shows a small window
with a list of settings that can be toggled on and off. When a player moves this 
window, resizes it or even closes it, the window state is persisted by the 
**[configuration structure](configuration)**, which means the last position, size and
visibility are not directly set by players. But when they toggle the settings inside 
this window, the values are stored in the **settings structure**, described below.

And finally, configurations are only changed programmatically, while settings can be
changed by players by running chat commands and interacting with UI elements. And 
this is one of the settings motivations when designed: to allow automatic UI elements
to be created from the addon settings.

## Usage

Creating a setting instance is pretty simple and straightforward. Its chained 
methods allow to build a new instance and set its properties in a single call like
this:

```lua
local group = library:new('SettingGroup')

-- group setters called here

local setting = library:new('Setting')
    :setAccessibleByCommand(true)
    :setDefault('default value')
    :setDescription('This is a setting description')
    :setGroup(group)
    :setId('settingId')
    :setLabel('Setting Label')
    :setScope('player')
    :setType('string')
```

:::warning Data storage

It's important to note that the code above will work as expected only **if the addon
instantiates the library with a data table set.**
[Read this](../core/addon-properties.md#data) for more information as that's the only
way settings will be persisted when players reload the game.

:::

Let's break down the chained methods used in the example above:

* `setAccessibleByCommand`: sets whether the setting can be changed by players using
  chat commands. It defaults to `true` when not called.
* `setDefault`: sets the default value for the setting. When the setting value is
  retrieved and it's not set, this value will be returned. If not informed, it will
  default to `nil`.
* `setDescription`: sets the setting description. It's used by the library in any 
  visual representation of the setting like UI elements and chat command outputs.
* `setGroup`: sets the setting group. It's used to group settings in the UI elements
  and also to build the setting fully qualified id.
* `setId`: sets the setting id. It's used to identify the setting and must be unique
  **within the group.** Which means two settings may have the same id as long as they
  belong to different groups.
* `setLabel`: sets the setting label. It's used by the library in any visual 
  representation of the setting like UI elements.
* `setScope`: sets the setting scope. It can be either `global` or `player`. The 
  global settings are shared among all players, while player settings are unique for
  each player. The `Setting` class has constants for these values so devs don't need
  to hardcode them.
* `setType`: sets the setting type. Although the library doesn't enforce type 
  checking, it's important to set it correctly as it's used by the library in any 
  forms of visual representation of the setting to let players know what kind of
  value they're dealing with. The `Setting` class has constants for these values so 
  devs don't need to hardcode them.

## Getting and setting values

Once a setting is instantiated, it can be used to get and set a value to be persisted
in the addon's data table.

```lua
local setting = -- setting instantiation here

-- setting value
setting:setValue('my value')

-- the code above will store 'my value' in the addon's data table's
-- global or player scope, depending on the setting scope

-- getting the value
local value = setting:getValue()
```

When updating a value (changing it with a new value, different from the current one),
the library will trigger the `SETTING_UPDATED`
[event](../facades/events.md#setting_updated) and the payload will contain the 
setting **fully qualified id**, **old value** and **new value**. Which means that 
addons can watch for this event and react to setting changes like this:

```lua
library.events:listen('SETTING_UPDATED', function(id, oldValue, newValue)
    -- do something with the setting change here
end)
```

It's also possible to use the `Setting:isTrue()` method when dealing with boolean
settings in many formats like `1`, `true`, `yes` and a few more covered by
[Bool](../support/bool).

## Setting Groups

Settings in Stormwind Library were designed to **always belong to groups.** The 
reason for this is to have it prepared for a second phase in this structure where
settings will be automatically converted into UI elements for auto generated settings
[pages](../views/window#adding-content-to-the-window).

Although not available yet in v1.13.0 (as of this writing), by creating settings 
with groups in mind, the impact of this resource will be minimal when the feature is 
released.

Groups can be easily instantiated and set up like this:

```lua
local group = library
    :new('SettingGroup')
    :setId('groupId')
    :setLabel('Group Label')
```

After that, settings can be added to it:

```lua
local setting = library
    :new('Setting')
    :setID('settingId')
    
group:addSetting(setting)
```

Once a setting is added to a group, it's fully qualified id will be built using the
group id and the setting id. Using the example above, it will be `groupId.settingId`.
That's the id that will be used by addons to retrieve settings instances and, of 
course, their values.

## The Settings class

When the library is instantiated, it may create a `Settings` instance in case a data
table [has been set](../core/addon-properties#data). This instance is accessible
by the `settings` property in the library table root and it's used to handle all 
addon settings.

Addons must start by creating setting groups:

```lua
local groupA = library
    :new('SettingGroup')
    :setId('groupA')
    :setLabel('Group A')

local groupB = -- instantiate group B here
local groupC = -- instantiate group C here and so on
```

After that, settings can be added to these groups:

```lua
local settingA = -- instantiate setting A here
local settingB = -- instantiate setting B here and so on

groupA:addSetting(settingA)
groupB:addSetting(settingB)
```

And finally, the groups can be added to the settings instance:

```lua
library.settings:addSettingGroup(groupA)
library.settings:addSettingGroup(groupB)
```

Alternatively, settings can be added directly to the settings instance:

```lua
library.settings:addSetting(settingA, 'groupA')
library.settings:addSetting(settingB, 'groupB')
```

Note that in this case, the group id must be passed as the second argument to the
`addSetting` method. In case it's not passed, the library will assume the settings is
being added to the default group, which is called **General** (id = `general`).

```lua
-- adding settingA to the general group
library.settings:addSetting(settingA)
```

Once the settings are added to the settings instance, they're already part of the
addon settings and can be retrieved by their **fully qualified id:**

```lua
-- this will return the Setting A instance which is in Group A
local setting = library.settings:getSetting('groupA.settingA')

-- this will return the Setting B instance which is in the general group
local setting = library.settings:getSetting('settingB')
```

:::warning Settings:setting() returns an instance, not a value

Please, note that the `Settings:setting()` method returns the setting instance, not
its stored value. To get the value, use result's `getValue()` method, but remember
that the instance can be nil for invalid settings, which means some validation is 
required.

:::

A shortcut is also available to get setting instances by their fully qualified id:

```lua
-- this will return the same as library.settings:setting('groupA.settingA')
local setting = library:setting('groupA.settingA')
```