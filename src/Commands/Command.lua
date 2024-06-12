--[[--
The command class represents a command in game that can be executed with
/commandName.

Commands in the Stormwind Library are structured in two parts being:

1. The command operation
2. The command arguments

That said, a command called myAddonCommand that shows its settings screen
in dark mode would be executed with /myAddonCommand show darkMode.

@classmod Commands.Command
]]
local Command = {}
    Command.__index = Command
    Command.__ = self
    self:addClass('Command', Command)

    --[[--
    Command constructor.
    ]]
    function Command.__construct()
        return setmetatable({}, Command)
    end

    --[[--
    Returns a human readable help content for the command.

    @treturn string a human readable help content for the command
    ]]
    function Command:getHelpContent()
        local content = self.operation

        if self.description then
            content = content .. ' - ' .. self.description
        end

        return content
    end

    --[[--
    Sets the command arguments validator.

    A command arguments validator is a function that will be executed before
    the command callback. It must return 'valid' if the arguments are valid
    or any other value if the arguments are invalid.

    @tparam function value the command arguments validator

    @return self

    @usage
        command:setArgsValidator(function(...)
            -- validate the arguments
            return 'valid'
        end)
    ]]
    function Command:setArgsValidator(value)
        self.argsValidator = value
        return self
    end

    --[[--
    Sets the command description.

    @tparam string description the command description that will be shown in the help content

    @return self
    ]]
    function Command:setDescription(description)
        self.description = description
        return self
    end

    --[[--
    Sets the command operation.

    @tparam string operation the command operation that will be used to trigger the command
    callback

    @return self
    ]]
    function Command:setOperation(operation)
        self.operation = operation
        return self
    end

    --[[--
    Sets the command callback.

    @tparam function callback the callback that will be executed when the command is triggered

    @return self
    ]]
    function Command:setCallback(callback)
        self.callback = callback
        return self
    end

    --[[--
    Validates the command arguments if the command has an arguments validator.

    If no arguments validator is set, the method will return 'valid' as by the
    default, the command must consider the user input as valid to execute. This
    also allows that addons can validate the arguments internally.

    @param ... The arguments to be validated

    @treturn string 'valid' if the arguments are valid or any other value otherwise
    ]]
    function Command:validateArgs(...)
        if self.argsValidator then
            return self.argsValidator(...)
        end

        return 'valid'
    end
-- end of Command