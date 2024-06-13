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
execution.
1. **Callback:** the `setCallback(callback)` expects a function that will be
executed when the library captures a command. This function may expect
parameters that will be parsed by the commands handler.
1. **Description:** optional property set with `setDescription(description)`
that will also store additional information for that command. When defined,
the [default help operation](commands-handler#the-help-operation) will print
it after the operation name.
1. **Arguments Validator:** optional function that will be executed before the
callback. It should return a **string** with `'valid'` when the arguments are
valid, or any other string with the error message to be printed in the chat.
   * As posted above, this is an optional feature that will save some sanity
     checks in the callback function and when not provided, the library will
     assume that arguments are always valid.

## Requirements

In order to add commands, the library must be initialized with the `command`
property. After that, every command instance created in the example below will
be registered as an operation that will be executed by the registered command.

Read the [Addon Properties](../core/addon-properties) documentation for more
reference.

## Example

Imagine an addon that needs to register a **clear** command that will clear
a table. Something like a cache clear. The addon holds the library instance
in a property called `library`.

First, the library must be initialized with the `command` property:

```lua
CustomAddon.library = StormwindLibrary.new({
  command = 'myAddon',
  -- other properties here
})
```

After that, it's possible to register any other commands, called operations,
as necessary.

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

In game, running the following line in the chat will execute the command:

```shell
/myAddon clear
```

## Validating arguments

See the example above where the `commandExecution` function is expecting two
arguments and is printing them. It could be updated to validate the arguments
like this:

```lua
function command:commandExecution(arg1, arg2)
    if not arg1 then
        print('arg1 is required')
        return
    end

    if arg2 and tonumber(arg2) < 0 then
        print('arg2 must be a positive number')
        return
    end

    -- other validations here...

    print('command executed with arg1 = ' .. arg1 .. ', and arg2 = ' .. arg2)
end
```

For many commands, it will inevitably lead to a lot of validation code in their
callback functions. That would also makes unit tests more complex. To separate 
responsibilities, it's possible to use the `setArgsValidator()` method to 
provide a function that will be executed before the callback.

The function must return a string with `'valid'` when the arguments are valid,
or any other string with the error message to be printed in the chat.

```lua
-- instantiates a command using the library factory
local command = CustomAddon.library:new('Command')

command:setArgsValidator(function (arg1, arg2))
    if not arg1 then
        return 'arg1 is required'
    end

    if arg2 and tonumber(arg2) < 0 then
        return 'arg2 must be a positive number'
    end

    -- other validations here...

    return 'valid'
end
```

When the command is executed, the commands handler will execute the validator
function before the callback. If the validator returns `'valid'`, the callback
will be executed. Otherwise, the error message will be printed in the chat.