# Minimap Icon

The minimap icon is a small icon that appears in the top right corner of the screen
around the game's minimap. A large number of addons use this icon to provide quick
access to their settings or features.

One of the most popular ways to create minimap icons is by using the
[LibDBIcon-1.0](https://www.curseforge.com/wow/addons/libdbicon-1-0/files/305165) 
which raised the question: should Stormwind Library "reinvent the wheel" and create
its own minimap icon structure or should it use a good existing one?

The decision was to create its own library to handle minimap icons so developers may
need to import fewer libraries in order to have a full addon setup. Still, 
considering that Stormwind Library has its own
[configuration system](../core/configuration), the minimap icon class can use it to
persist the icon's state.

## Usage

The minimap icon structure is a single class with chained setters to configure it 
before its creation. The following example will show how to create a minimap icon 
and use it to execute callbacks.

```lua
local myMinimapIcon = library
    :new('MinimapIcon', 'my-minimap-icon-id')
    :setFirstAnglePosition(45)
    :setIcon('Interface\\Icons\\INV_Misc_QuestionMark')
    :setCallbackOnLeftClick(function () print('Left button clicked') end)
    :setCallbackOnRightClick(function () print('Right button clicked') end)
    :setTooltipLines({
        'My Addon',
        'Click here to open the settings',
        'Hold SHIFT and drag to move this icon',
    })
    :create()
```

Here is a breakdown of the methods used in the example:

- `setFirstAnglePosition()`: sets the first angle position of the icon in 
  **degrees**. The default value is 225.0. It's important to mention that the 
  angle represented by 0.0 is the right side (or 3 o'clock, east) of the minimap, 
  and the angle increases counterclockwise, which means that 90.0 is the top side 
  (or 12 o'clock, north), 180.0 is the left side (or 9 o'clock, west), and 270.0 is 
  the bottom side (or 6 o'clock, south).
- `setIcon(string)`: sets the icon texture path. The icon texture should   
  represent a square image, like `Interface\\Icons\\INV_Misc_QuestionMark`.
- `setCallbackOnLeftClick(function)`: sets the callback function to be executed 
  when the left mouse button is clicked. If no callback is set, nothing will
  happen when the left mouse button is clicked on the icon.
- `setCallbackOnRightClick(function)`: sets the callback function to be executed 
  when the right mouse button is clicked. If no callback is set, nothing will
  happen when the right mouse button is clicked on the icon.
- `setTooltipLines(table)`: sets the tooltip lines to be displayed when the mouse
  hovers over the icon. The table should contain strings with the text to be 
  displayed. When no tooltip is set, the default tooltip lines will be the addon
  name and a quick description of how to move the icon.

## Moving the icon

The default way to move the icon is by holding the SHIFT key and dragging it.

In its first version, it's not possible to change that, unless extending the
`MinimapIcon` class and overriding the script callbacks. This feature may be
implemented in future versions, depending on the feedback received.

## Showing and hiding the minimap icon

In the World of Warcraft API, frames have the `Show()` and `Hide()` methods to
control the frame visibility. Although the `MinimapIcon` class has the same 
methods, they're used internally as the class exposes the `setVisibility()`
method that accepts a boolean value to show or hide it.

**Addons should always use `setVisibility()`** to show or hide the minimap icon as 
they persist the frame visible state between interface reloads. In other words, if 
users hide the icon, the library will save this state and when the game interface 
is reloaded, the icon will remain hidden.

## Persisting the icon state

The minimap icon class uses the configuration system to persist the icon's state.

That means that the icon's position and visibility are automatically saved as a
[global setting](../core/configuration) as long as the addon instantiates the
library with a [table of settings](../core/addon-properties#data). So it's highly
recommended to use the configuration system to persist the icon's state, otherwise
players will lose their icon's position and visibility every time they reload the UI.