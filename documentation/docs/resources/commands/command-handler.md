---
sidebar_position: 3
title: Command Handler
---

The command handler is a class that intercepts all commands registered by an
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
1. After that, each `add(command)` call will map its operation and callback.
1. When the command is executed in game, the library will have its callback
triggered along with the arguments. The first argument is considered the 
operation, so it will determine the proper callback to trigger. This 
callback is the one exposed by the command object.

:::warning @TODO

* Describe how it handles the other arguments

:::