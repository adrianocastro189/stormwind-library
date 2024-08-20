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
* Add controls grouped by pages to easily switch between them, so the window
  can be reused for different addon features
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
    :setFirstPosition({point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0})
    :setFirstSize({width = 250, height = 400})
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

**Addons should always use the `setVisibility()` or `toggleVisibility()` methods** 
to show or hide the window as they persist the window visible state between 
interface reloads. In other words, if users close the window, the library will save 
this state and when the game interface is reloaded, the window will be hidden.

```lua
-- consider a window instance created by
local window = library:new('Window', 'my-window-id')

-- hides the window
window:setVisibility(false)

-- shows the window
window:setVisibility(true)
```

The `toggleVisibility()` method was introduced in Stormwind Library version 1.12.0 
to show the window if it's hidden and hide it if it's shown.

```lua
-- consider a window which is visible
window:setVisibility(true)

-- toggles the window visibility, hiding it
window:toggleVisibility()

-- if called again, it will show the window
window:toggleVisibility()
```

## Adding content to the window

One of the motivations to create the Window class was to provide an easy way
to add content that was also wrapped by a vertical scroll bar in case it's
big enough to overflow the window.

:::note The old `Window:setContent()` method

Just a little bit of history to add context to the current implementation.

The first Window version used to provide a method called `setContent()`,
accepting a list of frames that would be automatically positioned in the
window content area like blocks.

However, that approach introduced some limitations, especially when addons
needed to add frames that would replace the whole content area. Given the
way blocks are vertically stacked, it was hard to manage the inner frames
and hide or show the right ones according to the addon needs.

As an example, if the addon wanted to have a settings section and the main
section showing whatever information it needed, it would have to hide them
and move the section relative points programmatically, which was a bit
cumbersome.

:::

Version 1.9.0 introduced a new approach to add content to a window: the window
**page**.

A window page is instantiated by the `WindowPage` class and it has a method 
called `setContent()` that accepts a table of frames that will be 
**automatically positioned** in the page content area from top to bottom and 
width that's bound to the window width.

That way, addons can add frames to the window content without worrying about
positioning them as long as they pass the frames in the right order.

It's possible to create multiple pages, one per addon feature, like a settings
page, another one for the main addon content, an "about" page, etc. And then
once a page is created, it can be sent to the window by calling the 
`Window:addPage()` method.

Considering that every window page must be created with a page id, it's just a
matter of calling `Window:setActivePage(pageId)` to show the right page.

:::info Free inner frames layout

_What if my addon needs to add inner frames freely that don't behave as 
blocks?_

It's totally possible, as
the `contentFrame` is a public property of the `WindowPage` class and can be 
used to position frames. The `setContent()` method is just a helper to add 
frames as blocks, but it's not mandatory to use it.

It's totally fine to use `contentFrame` as a parent and relative point to add
frames that don't need to be stacked vertically.

:::

See this example on how to add inner frames that behave as blocks to the
window content area:

```lua
local window = library
    :new('Window', 'my-window')
    :create()

-- just a simple component factory to create edit boxes and place them in the
-- pages content area, but it works for any kind of frame
local function getEditBox(text)
   local editBox = CreateFrame('EditBox')
   editBox:SetMultiLine(true)
   editBox:SetSize(100, 100)
   editBox:SetPoint('TOP', 0, 0)
   editBox:SetFontObject(GameFontNormal)
   editBox:SetText(text)
   editBox:SetAutoFocus(false)
   editBox:SetTextInsets(10, 10, 0, 0)
   editBox:SetEnabled(false)
   editBox:Show()
   return editBox
end

-- the :create() method must be called before adding content as the
-- window content area is created by this method and won't be triggered
-- by the class constructor
local settPage = library:new('WindowPage', 'settings'):create()
local mainPage = library:new('WindowPage', 'main'):create()

settPage:setContent({
    getEditBox('Settings page'),
    getEditBox('Setting#1'),
    getEditBox('Setting#2'),
})
mainPage:setContent({
    getEditBox('Main addon content page'),
    getEditBox('Component#1'),
    getEditBox('Component#2'),
})

window:addPage(settPage)
window:addPage(mainPage)

-- this is optional, but allows testing the window with easy chat commands
_G['myWindow'] = window

-- shows the settings page
myWindow:setActivePage('settings')

-- shows the main page
myWindow:setActivePage('main')
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