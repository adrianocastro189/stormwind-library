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
resizes, close, etc, the window, it will save its state in a saved variable
managed by the library configuration instance and once the frame is shown 
again, the "first values" will be ignored and the ones saved will be used.