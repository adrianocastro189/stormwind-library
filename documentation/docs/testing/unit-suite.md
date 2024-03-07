---
sidebar_position: 1
title: Unit Suite
---

:::note Lua version

For the steps below, Lua 5.4 will be used as the installed version, but the
library should run well for any versions after, and including, 5.1.

:::

The Stormwind Library uses the [luaunit](https://github.com/bluebird75/luaunit) library to house the unit test suite.

In order to be able to run the unit tests suite, follow the steps below:

1. Make sure Lua can be executed in a command line by following the
[installation](https://www.lua.org/download.html) steps
    * You should be able to run a command like `lua54` in your command line
tool and execute any lua code like `print('Hello World')`
1. Place the `luaunit.lua` that's available in the `tests` directory in the same folder where the Lua binaries are localized in the machine
    * As an example, if the `lu54.exe` is inside `C:\lua`, the `luaunit.lua`
should be there as well
1. Go to the **root folder** and run `lua54 .\tests\unit.lua`