# Output

The output structure controls everything that can be printed
in the Stormwind Library and also by the addons.

Its usage could be easily replaced by `print()` calls, but the
library offers this facade to allow better print formatting, mocking,
testing, logging, etc.

The output instance can also be replaced by any addons to forward
all the produced output.

## Printing

Calling Lua's default `print()` function will work perfectly in any
addon using the Stormwind Library, however, it's recommended to use
its default output instance:

```lua
library.output:print('Content to be printed')
```

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