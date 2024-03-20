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