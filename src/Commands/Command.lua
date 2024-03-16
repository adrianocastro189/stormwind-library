--[[
The command class represents a command in game that can be executed with
/commandName.

Commands in the Stormwind Library are structured in three parts being:

1. The command name
2. The command action
3. The command arguments

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
    Sets the command action.

    @return self
    ]]
    function Command:setAction(action)
        self.action = action
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
    
    --[[
    Sets the command name.

    @return self
    ]]
    function Command:setName(name)
        self.name = name
        return self
    end
-- end of Command