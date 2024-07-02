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

Will produce:

**<span style={{ color: 'red' }}>MyAddon |</span> Content to be printed**

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

## The error() method

When a player tries to cast a spell that's on cooldown, or attempt to mount
in a no-mount zone, the game will print an error message in red color in
the middle of the screen. That's the error message UI frame.

Stormwind Library provides a method to print messages in this same frame that
shares the stacking behavior with other error messages. This method is 
available in the output structure and can be called like this:

```lua
library.output:error('Content to be printed')
```

In case the UI error frame is not available, the error message will be printed
in the chat frame instead, using the `Output:out()` method.

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

## Testing mode

This class has a test mode that allows the output to be easily tested
instead of printing the messages to the system output. That way, unit test
cases don't need to mock the `print()` function nor the output structure.

Although Output was designed to allow replacing the `print()` function
when necessary, it's safe to say that almost every addon will use the
`out()` function directly so lots of repeated code can be avoided by using 
this structure in testing mode.

To set the library output in test mode, you can use the setTestingMode()
method like this:

```lua
library.output:setTestingMode()
```

After that, you can use the printed() method to check if a message was
printed in the output structure.

```lua
library.output:out('Hello, World of Warcraft!')

lu.assertTrue(library.output:printed('Hello, World of Warcraft!'))
```

## Dump and dying - dd()

The library's `dd()` function is inspired by PHP Laravel's `dd()` function 
and offers a quick way to dump variables and stop the execution of the 
script. **It's intended to be used for debugging purposes only.**

Once called with one or more variables, it will print the their structures 
using the standard `print()` method, which **can't be replaced** like 
`Output:print()`, considering that `dd()` is intended for debugging 
purposes only.

This method is also prepared to avoid circular references and won't break if
a table has a reference to itself. However, it still deserves lots of 
improvements that will be implemented by demand.

Finally, `dd()` can be used in game as well, however, the chat frame has a
line limit that can be reached if the dumped variable is too big, so its usage
is recommended for small tables and variables and mostly for local testing.

```lua
local myTable = { key = 'value' }

-- this will print the table and stop the execution
library:dd(myTable)
```