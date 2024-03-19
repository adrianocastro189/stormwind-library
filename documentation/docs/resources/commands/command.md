---
sidebar_position: 2
title: Command
---

The command object is a simple DTO object that can also house the callback
if the addon has a good class structure.

It basically holds the required information to register a slash command in
the game:

1. **Operation:** the `setOperation(operation)` expects a string operation
name which will be the one used by the library to forward the command 
execution
1. **Callback:** the `setCallback(callback)` expects a function that will be
executed when the library captures a command. This function may expect
parameters that will be parsed by the command handler.
1. **Description:** optional property set with `setDescription(description)`
that will also store additional information for that command.

## Example

Imagine an addon that needs to register a **clear** command that will clear
any inner list. The addon holds the library instance in a property called
`library`.

```lua
-- instantiates a command using the library factory
local command = CustomAddon.library:new('Command')

function command:commandExecution(arg1, arg2)
    -- execute any addon code here
    print('command executed with arg1 = ' .. arg1 .. ', and arg2 = ' .. arg2)
end

command
    :setDescription('Clears the addon cache')
    :setOperation('clear')
    :setCallback(command.commandExecution)

-- registers the command in the library
CustomAddon.library.commands:add(command)
```