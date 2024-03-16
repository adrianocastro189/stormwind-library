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
executed when the library captures a command.

:::warning @TODO

* Complete this guide with the parameters list.
* Complete this guide with the command description.

:::

## Example

Imagine an addon that needs to register a **clear** command that will clear
any inner list. The addon holds the library instance in a property called
`library`.

```lua
-- instantiates a command using the library factory
local command = CustomAddon.library:new('Command')

function command:commandExecution()
    -- execute any addon code here
    print('command executed')
end

command
    :setOperation('clear')
    :setCallback(command.commandExecution)

-- registers the command in the library
CustomAddon.library.commands:add(command)
```