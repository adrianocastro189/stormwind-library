# Lua Docs

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