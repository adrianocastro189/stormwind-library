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
-- end of Command