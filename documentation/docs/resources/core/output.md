# Output

The output structure controls everything that can be printed
in the Stormwind Library and also by the addons.

Its usage could be easily replaced by `print()` calls, but the
library offers this facade to allow better print formatting, mocking,
testing, logging, etc.

The output instance can also be replaced by any addons to forward
all the produced output.

## The out() method

This is the default printing method for the output structure that addons
and the library itself must use almost all the times.

It basically adds a formatting to prefix every message with the addon
name wrapped in the addon's primary color.

Consider an addon called **MyAddon** whose primary color is red. Then
running:

```lua
library.output:out('Content to be printed')
```

Will produce **[red]**MyAddon**[red]** - Content to be printed, where
**[red]** is just a placeholder to represent the red color in the game's
chat.

If the addon needs to print a non-formatted message, then it should use
`output:print()` instead. Read the section below for more information.

## The print() method

Calling Lua's default `print()` function will work perfectly in any
addon using the Stormwind Library, however, it's recommended to use
its default output instance:

```lua
library.output:print('Content to be printed')
```

:::tip Use out() instead of print()

Although there's a `print()` method in the output structure, it's
recommended to use `out()` instead, as it will format the message with
the addon name and color it according to the primary color from the
addon properties.

Consider the `print()` method useful for replacing the standard output,
like sending all to a frame instead of Lua's default print function.

:::

## Coloring strings

When printing content to World of Warcraft chat, it's very common to
use colors. Those colors have a specific formatting that's hard for 
humans to read as they mix the hexadecimal color with a couple of other
characters.

The output structure has a method to easily wrap any string in a
hexadecimal color that can be called with:

```lua
-- do not pass the # character
library.output:color('Content to be printed in white', 'FFFFFF')
```

The second parameter represents the color in hexadecimal **with no #**,
but this is an optional parameter. When omitted, the **primary color** set
in the [addon properties](addon-properties#colors) will be used instead.

And even if no primary color was set, the method will return the original
input, which is the string with no wrapped color.