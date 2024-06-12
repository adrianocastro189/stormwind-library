---
sidebar_position: 1
title: Overview
---

Slash commands in World of Warcraft are executed in the chat box that can
trigger lots of things for a character as well as for their UI.

Examples of slash commands:

* `/m` opens the macro window
* `/dance` puts the character to dance
* `/logout` logs the character off

There are lots of native commands, and addons can introduce their own.

## Stormwind Library commands

It's very easy to add new slash commands to the game and you can do that 
with a couple of code lines.

The Stormwind Library offers a small structure to add commands in a more OOP
approach, which means you can wrap a command in a Lua class in case its 
complex enough to be handled by a procedural script.

That said, if an addon needs to use the library commands resources, it must
adhere to a few rules. Otherwise, the addon can "manually" introduce 
commands in the traditional way and bypass this resource.

1. **Single command name:** the library allows only a single command per 
addon. Which means the addon can't register `/myAddonCommand` and
`/myAddonAnotherCommand`, instead, it must use the concept of command 
operations.
2. **One callback per operation:** considering a single command per addon,
the first argument is considered the operation, which means something like
the real command inside the addon. As an example `/myAddonCommand show` and
`/myAddonCommand hide` are commands with two different operations: **show**
and **hide**.
    * Still, a command callback may accept arguments, so a command like
    `/myAddonCommand show simpleUi darkMode` will call the **show** callback
    passing `simpleUi` and `darkMode` as arguments.

If the addon can handle commands in the proposed way, then it can use the
resources below to register, listen and trigger callbacks for slash 
commands.

* [Creating and registering a command](command)
* [How the commands handler works](commands-handler)

## Current limitations

The current command structure has a few limitations that developers need to
be aware. These limitations can be covered in the future depending on their
demand and more clarity on how this structure is being used:

1. **Commands must have an operation:** a command can't be created without
the operation, meaning that `/myAddonCommand` with no arguments won't have
any effects and won't forward to the addon callbacks.
    * For cases where the addon needs only one single command, prefer to use
    a default operation representing what the command opens or runs, examples:
        * `/myAddonCommand show`
        * `/myAddonCommand config`
        * `/myAddonCommand start`
    * By default, calling `/myAddonCommand` will trigger the **help** operation
      as better explained [here](commands-handler#the-help-operation).
1. **Arguments can't escape quotes yet:** when calling commands handled by the
Stormwind Library, arguments are separated by a space (` `) meaning that
`/myAddonCommand operation arg1 arg2` will call the operation passing both
arguments as two Lua variables and it also allows wrapping strings with
spaces in `""` or `''`. However, until the current version, it's not possible
to escape quotes in a way that the argument can't contain those characters.