--[[
The command class represents a command in game that can be executed with
/commandName
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
-- end of Command