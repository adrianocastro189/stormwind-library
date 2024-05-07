# Window

Working with frames in the World of Warcraft API usually envolves a lot of
code to create, position, manage, add scrollbars, persist state between 
interface reloads, and so on.

Although the game frames are flexible and powerful, they can be a bit
overwhelming for developers who just want to create a simple window to show
some information and simple controls for players.

When a simple window with basic features is needed, the `Window` class can be
used or extended to create a new window and add it to the game interface.

The Stormwind Library provides a simple way to create windows with basic
features, like:

* Showing a title
* Showing a close button
* Resizing and moving the window
* Limiting the window size
* Adding a scrollbar to the main window content
* Persisting the window position and size between interface reloads
* An easy way to attach frames to the window with a vertical layout
* More to come...

## How to create and show a window

Although `Window` can be extended to create more complex windows, this article
will focus on how to instantiate and show a simple window.

```lua
local window = library
    :new('Window', 'my-window-id')
    :create()
```

And that's it! The code above will create a blank window at the center of the
screen with a default size that's probably smaller than you want, but it will
be enough to get you started.

Now, let's see how to create the same window with a bit more customization:

```lua
local window = library
    :new('Window', 'my-window-id')
    :setTitle('My Window')
    :setFirstPosition('CENTER', 'CENTER', 0, 0)
    :setFirstSize(250, 400)
    :setFirstVisibility(true)
    :create()
```

Although the code above uses some default values, it shows how to set the
window title, position, size, and initial visibility.

## Showing and hiding the window

In the World of Warcraft API, frames have the `Show()` and `Hide()` methods to
control the frame visibility. Although the `Window` class has the same 
methods, they're used internally as the class exposes the `setVisibility()`
method that accepts a boolean value to show or hide the window.

Addons should use the `setVisibility()` method to show or hide the window as
they persist the window visible state between interface reloads. In other 
words, if users close the window, the library will save this state and when 
the game interface is reloaded, the window will be hidden.

```lua
-- consider a window instance created by
local window = library:new('Window', 'my-window-id')

-- hides the window
window:setVisibility(false)

-- shows the window
window:setVisibility(true)
```
## Adding content to the window

One of the motivations to create the Window class was to provide an easy way
to add content that was also wrapped by a vertical scroll bar in case it's
big enough to overflow the window.

That said, the class has a `setContent()` method that accepts a table of 
frames that will be **automatically positioned** in the content area from top
to bottom and width that's bound to the window width.

That way, addons can add frames to the window content without worrying about
positioning them as long as they pass the frames in the right order and 
respect a few rules. Let's call them "inner frames".

1. Inner frames shouldn't be created with a width as they'll occupy the whole 
content area width. **Consider them blocks that will be stacked vertically!**
1. The addon must be responsible for hiding the inner frames in case it must
update the whole content area. The library doesn't manage the inner frames
(**at least in the current version**).

:::info Free inner frames layout

_What if my addon needs to add inner frames freely that don't behave as 
blocks?_

It's totally possible, as
the `contentFrame` is a public property of the `Window` class and can be used
to position frames. The `setContent()` method is just a helper to add frames
as blocks, but it's not mandatory to use it.

:::

See this example on how to add inner frames that behave as blocks to the
window content area:

```lua
local window = library:new('Window', 'my-window-id')
    -- :chained method as described above
    :create()

local settingsBlock = CreateFrame('Frame', nil, window.contentFrame, "BackdropTemplate")
settingsBlock:SetHeight(35)
settingsBlock:SetBackdrop(...)
settingsBlock:SetBackdropColor(...)
-- any other visual settings method calls

local optionsBlock = CreateFrame('Frame', nil, window.contentFrame, "BackdropTemplate")
optionsBlock:SetHeight(100)
-- any other visual settings method calls

local notesBlock = ...

-- this will add the blocks to the window content area where each block will
-- occupy the whole width and be stacked vertically
window:setContent({ settingsBlock, optionsBlock, notesBlock })
```

:::note Keep an eye on this documentation

The philosophy behind the library is to grow organically based on addons
demands and developers feedback.

It's most likely that the `Window` class will have more features in the future
and this documentation will be updated to reflect those changes. Make sure to
check the [changelog](../../changelog) frequently to see what's new.

:::

## Window persistent state

On the example above, look at `id` parameter passed to the `Window` 
constructor. This id is used to persist the window state between interface 
reloads and that's automatically done by the library. However, for that to 
work, the window id must be unique, and the library must be instantiated with the `data` property ([read more about that here](../core/addon-properties#data)).

In case the addon passes the `data` property to the library initialization, 
it will have a [configuration manager](../core/configuration) that will store 
the window size, position, visibility, etc, between interface reloads.

That's why most of the setters start with `setFirst` instead of just `set`.
Because that means the library will use the first value set to the window for
its initial state. After that, the window state will be managed by the
library configuration manager. Which means, at the moment a player moves, 
resizes, closes, etc, the window, it will save its state in a saved variable
managed by the library configuration instance and once the frame is shown 
again, the "first values" will be ignored and the ones saved will be used.

By default, the window state will be saved in the global context, meaning that
players will share the same window state. However, the library allows the
addon to save the window state in the character context by calling
`Window:setPersistStateByPlayer(true)`.

```lua
-- if a player changes the window size, position, visibility, etc, the window
-- state will be reflected for any other players in the same account
local sharedWindow = library
    :new('Window', 'window-id')
    :create()

-- in this case, the window state will be saved for each player separately
local playerWindow = library
    :new('Window', 'window-id')
    :setPersistStateByPlayer(true)
    :create()
```

:::warning Set persistence before creating the window

Due to how windows are built and have their properties managed, the
`create()` method will get the state before rendering the frames.

That means that 
the `setPersistStateByPlayer()` method must be called before `create()`, 
otherwise, the window state will be initially loaded from the global context
and then persisted in the player context, having no effects on subsequent
interface reloads.

:::