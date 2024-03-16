--[[
The commands handler provides resources for easy command registration,
listening and triggering.
]]
local CommandsHandler = {}
    CommandsHandler.__index = CommandsHandler
    CommandsHandler.__ = self

    --[[
    CommandsHandler constructor.
    ]]
    function CommandsHandler.__construct()
        local self = setmetatable({}, CommandsHandler)

        self.operations = {}

        return self
    end

    --[[
    Adds a command that will be handled by the library.

    The command must have an operation and a callback.

    It's important to mention that calling this method with two commands
    sharing the same operation won't stack two callbacks, but the second
    one will replace the first.
    ]]
    function CommandsHandler:add(command)
        self.operations[command.operation] = command.callback
    end

    function CommandsHandler:handle(commandArg)
        local args = self.__.str:split(commandArg or '', ' ')

        if #args < 1 then return end

        -- @TODO: Parse command arguments after the operation
        self:maybeInvokeCallback(args[1], {})
    end

    function CommandsHandler:maybeInvokeCallback(operation, args)
        if not operation then return end

        local callback = self.operations[operation]

        if callback then
            callback(unpack(args))
        end
    end

    function CommandsHandler:register()
        if not self.__.addon.command then return end

        local lowercaseCommand = string.lower(self.__.addon.command)
        local uppercaseCommand = string.upper(self.__.addon.command)

        _G['SLASH_' .. uppercaseCommand .. '1'] = '/' .. lowercaseCommand
        SlashCmdList[uppercaseCommand] = function (args)
            self:handle(args)
        end
    end
-- end of CommandsHandler

-- sets the unique library commands handler instance
self.commands = CommandsHandler.__construct()
self.commands:register()