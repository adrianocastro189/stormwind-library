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
local group = library.__:new('SettingGroup')

-- group setters called here

local setting = library.__:new('Setting')
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
  and also to build the setting full qualified id.
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