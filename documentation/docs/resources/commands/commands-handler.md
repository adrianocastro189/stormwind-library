---
sidebar_position: 3
title: Commands Handler
---

The commands handler is a class that intercepts all commands registered by an
addon. That allows the library to parse arguments and trigger the 
registered callbacks.

As mentioned in the [overview](overview), one of the motivations behind the
commands structure is to allow commands to behave as objects, and that's 
possible leaving all the command conditionals, parsing, etc, to the handler,
requiring commands to just expose a callback expecting the desired 
arguments.

* See how to register commands [here](command)

## How it works

1. When an addon initializes its library instance, it can pass a property in
the constructor representing the addon main command. That will make the 
library register the command during its initialization.
1. The library registers the command associating its own callback at this 
point.
1. After that, each `add(command)` call will map its operation and the command
itself.
1. When the command is executed in game, the library will have its callback
triggered along with the argument, which is broken by spaces.
    * When a command is executed in the game, everything after the command 
    itself becomes the argument. Example: `/myCommand arg1 arg2 arg3` will 
    trigger the callback with `arg1 arg2 arg3`.
    * The Stormwind Library commands handler was designed to forward the 
    arguments like an operating system console where arguments
    are separated by blank spaces. Arguments that must contain spaces can
    be wrapped by `"` or `'`. Example: `/myCommand arg1 "arg2 arg3"` will 
    result in two arguments `{'arg1', 'arg2 arg3'}`.
1. This list of arguments are divided, and the first argument is considered 
the command **operation**, so it will determine the proper callback to 
trigger in the addon. This callback is the one exposed by the command 
object.
1. The other arguments (if any) are passed to the operation callback.

## The help operation

By default, the commands handler offers a **help** operation that behaves as
a normal command. It basically prints all the available operations (except for
the help itself) along with their descriptions.

Addons that must need to override the help operation, simply create a command
and add it normally, so the default one will be replaced.

The commands handler was updated in [version 1.5.0](../../changelog) to also 
consider the help operation as the default one when no operation is passed. 
With that change, raw commands like `/myCommand` will work the same as `/myCommand help`.