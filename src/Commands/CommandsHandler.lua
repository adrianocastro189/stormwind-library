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

    --[[
    This function is responsible for breaking the full argument word that's
    sent by World of Warcraft to the command callback.

    When a command is executed, everything after the command itself becomes
    the argument. Example: /myCommand arg1 arg2 arg3 will trigger the
    callback with "arg1 arg2 arg3".

    The Stormwind Library handles events like a OS console where arguments
    are separated by blank spaces. Arguments that must contain spaces can
    be wrapped by " or '. Example: /myCommand arg1 "arg2 arg3" will result
    in {'arg1', 'arg2 arg3'}.

    Limitations in this method: when designed, this method meant to allow
    escaping quotes so arguments could contain those characters. However,
    that would add more complexity to this method and its first version is
    focused on simplicity.

    Notes: the algorithm in this method deserves improvements, or even some
    handling with regular expression. This is something that should be
    revisited in the future and when updated, make sure
    TestCommandsHandler:testGetCommandsHandler() tests pass.
    ]]
    function CommandsHandler:parseArguments(input)
        if not input then return {} end

        local function removeQuotes(value)
            return self.__.str:replaceAll(self.__.str:replaceAll(value, "'", ''), '"', '')
        end

        local result = {}
        local inQuotes = false
        local currentWord = ""
        
        for i = 1, #input do
            local char = input:sub(i, i)
            if char == '"' or char == "'" then
                inQuotes = not inQuotes
                currentWord = currentWord .. char
            elseif char == " " and not inQuotes then
                if currentWord ~= "" then
                    table.insert(result, removeQuotes(currentWord))
                    currentWord = ""
                end
            else
                currentWord = currentWord .. char
            end
        end
        
        if currentWord ~= "" then
            table.insert(result, removeQuotes(currentWord))
        end
        
        return result
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