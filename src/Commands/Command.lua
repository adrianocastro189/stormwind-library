--[[
The command class represents a command in game that can be executed with
/commandName.

Commands in the Stormwind Library are structured in two parts being:

1. The command operation
2. The command arguments

That said, a command called myAddonCommand that shows its settings screen
in dark mode would be executed with /myAddonCommand show darkMode.
]]
local Command = {}
    Command.__index = Command
    Command.__ = self
    self:addClass('Command', Command)

    --[[
    Command constructor.
    ]]
    function Command.__construct()
        return setmetatable({}, Command)
    end

    --[[
    Sets the command operation.

    @return self
    ]]
    function Command:setOperation(operation)
        self.operation = operation
        return self
    end

    --[[
    Sets the command callback.

    @return self
    ]]
    function Command:setCallback(callback)
        self.callback = callback
        return self
    end
-- end of Command