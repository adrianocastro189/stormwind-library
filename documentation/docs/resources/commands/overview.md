---
sidebar_position: 1
title: Overview
---

Slash commands in World of Warcraft are executed in the chat box that can
execute lots of things for a character as well as for the UI.

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
commands in the traditional way.

1. **Single command name:** the library allows only a single command per 
addon. Which means the addon can't register `/myAddonCommand` and
`/myAddonAnotherCommand`, instead, it must use the concept of command 
operations
2. **One callback per operation:** considering a single command per addon,
the first argument is considered the operation, which means something like
the real command inside the addon. As an example `/myAddonCommand show` and
`/myAddonCommand hide` are commands with two different operations: **show**
and **hide**
    * Still, a command callback may accept parameters, so a command like
    `/myAddonCommand show simpleUi darkMode` will call the **show** callback
    passing `simpleUi` and `darkMode` arguments

If the addon can handle commands in the proposed way, then it can use the
resources below to register, listen and trigger callbacks for slash 
commands.

* [Creating and registering a command](command)
* [How the command handler works](command-handler)