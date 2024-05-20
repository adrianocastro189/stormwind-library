# LuaDocs

Although the Stormwind Library is fully covered in this documentation page 
built over Docusaurus, the technical documentation is not well described
here, as its purpose is to provide a general overview of the library and
its features.

The technical documentation is intended to provide a more detailed view of
how methods and classes are implemented, as well as how they interact with
each other, what they expect and also their outputs.

For that reason, every method and property of the library should be covered
by Lua comments describing methods' signatures, parameters, and return
types.

## How to generate Lua documentation files

Lua documentation files are generated using the [ldoc tool](https://github.com/lunarmodules/ldoc),
and it's available through the `luarocks` package manager.

The steps below were written on April 7, 2024 and are valid for a Windows 11
environment with Lua 5.4. They should should differ in other environments
and Lua versions.

Future updates in this documentation may include steps for MacOS, Linux and
also for other Windows versions.

:::tip Note about the steps below

There are lots of ways to be able to run the `ldoc` tool. If you manage to
run it without installing **luarocks**, you can skip the steps below and
just run the `ldoc` command in the root folder of this project.

:::

1. Make sure to have LuaBinaries instead of only the Lua executable, so you
   have an `include` folder containing Lua headers; the one used in this
   guide was [lua-5.4.2_Win64_dllw6_lib.zip](https://luabinaries.sourceforge.net/download.html)
1. Download [luarocks-3.11.0-windows-64.zip (luarocks.exe stand-alone Windows 64-bit binary)](https://luarocks.github.io/luarocks/releases/)
1. Unzip `luarocks.exe` in the same folder your Lua installation is
   * If your environment variables are correctly set and you're able to
   run Lua from a command line tool, you can run `luarocks` right away
1. Download [GCC 13.2.0 (with POSIX threads) + LLVM/Clang/LLD/LLDB 17.0.6 + MinGW-w64 11.0.1 (UCRT)](https://winlibs.com/)
   and unzip the `mingw64` in the same folder your Lua installation is
1. Add the `mingw64\bin` folder to your PATH environment variable
1. Run the following commands
   ```shell
   luarocks install luafilesystem

   luarocks install penlight

   luarocks install ldoc
   ```
1. Add `C:\Users\{YOUR_USERNAME}\AppData\Roaming\luarocks\bin` to your PATH
   environment variable
1. Now you should be able to run the `ldoc` command from your command line
   and generate the documentation files

## Documentation standards

The documentation standards are based on the
[LDoc manual](https://lunarmodules.github.io/ldoc/manual/manual.md.html).

However, there are some rules that are not covered by the manual, so
these are a couple of standards that are used in the Stormwind Library
LuaDoc blocks:

1. Class and methods blocks use the `--[[--` doc block style.
1. The `@classmod` tag is used to define the class name and due to how the library is 
structured, the class "namespace" or "module" need to be placed before the class name separated 
by a dot, e.g. `Support.Arr`. That way the documentation will be generated in a more organized 
way.
1. Use `@local` when methods should be considered **private** or **protected**, in other words,
when they should not be used outside the class.
1. The `@usage` tag should be used to show examples of how to use the class
   and methods. Those can be idented with 4 spaces, just like a code block.
1. **Types**
   * Prefer the usage of `@tparam` and `@treturn` tags to define the types.
      * Don't use a `.` at the end of the setence, unless it has 2 or more
        phrases.
      * Prefer to not break lines, even if the line is longer than the current
        sizes as observed in other classes, unless it's really necessary by
        being too long or having multiple phrases.
      * Capitalize the first word describing the parameter or return type.
      * When using multiple types, separate them by a `|` character and prefer
        to sort them alphabetically, except when one of the types is `nil`, 
        which should be the last one, example: `number|string|nil`.
   * Prefer `integer` over `number` when the value must be an integer.
   * Prefer `boolean` over `bool`.
   * Use `any` when the type is not defined.

:::tip This section is a work in progress

This section will be fed with more information as the library grows and
standards become more clear.

:::

## Generated docs

The technical documentation for the Stormwind library is generated in the
`./documentation-ldoc` folder with the command:

```shell
# this command must be run from the ./dist folder
ldoc stormwind-library.lua -d ../documentation-ldoc -c ../config.ld -v --multimodule --all
```

As of now, the generated documentation is being pushed to the repository,
but that can be changed in the future.