--[[--
The commands handler provides resources for easy command registration,
listening and triggering.

@classmod Commands.CommandsHandler
]]
local CommandsHandler = {}
    CommandsHandler.__index = CommandsHandler
    CommandsHandler.__ = self

    --[[--
    CommandsHandler constructor.
    ]]
    function CommandsHandler.__construct()
        local self = setmetatable({}, CommandsHandler)

        self.operations = {}
        self:addHelpOperation()

        return self
    end

    --[[--
    Adds a command that will be handled by the library.

    The command must have an operation and a callback.

    It's important to mention that calling this method with two commands
    sharing the same operation won't stack two callbacks, but the second
    one will replace the first.

    @tparam Command command
    ]]
    function CommandsHandler:add(command)
        self.operations[command.operation] = command
    end

    --[[--
    This method adds a help operation to the commands handler.

    The help operation is a default operation that can be overridden in
    case the addon wants to provide a custom help command. For that, just
    add a command with the operation "help" and a custom callback.

    When the help operation is not provided, a simple help command is
    printed to the chat frame with the available operations and their
    descriptions, when available.

    @local
    ]]
    function CommandsHandler:addHelpOperation()
        local helpCommand = self.__:new('Command')

        helpCommand:setOperation('help')
        helpCommand:setDescription('Shows the available operations for this command.')
        helpCommand:setCallback(function () self:printHelp() end)

        self:add(helpCommand)
    end

    --[[--
    Builds a help content that lists all available operations and their
    descriptions.
    
    @NOTE: The operations are sorted alphabetically and not in the order they were added.
    @NOTE: The "help" operation is not included in the help content.
    
    @local

    @treturn table[string] A list of strings with the help content
    ]]
    function CommandsHandler:buildHelpContent()
        local contentLines = {}
        self.__.arr:map(self.operations, function (command)
            if command.operation == 'help' then return end

            local fullCommand = self.slashCommand .. ' ' .. command:getHelpContent()

            table.insert(contentLines, fullCommand)
        end)

        if #contentLines > 0 then
            table.sort(contentLines)
            table.insert(contentLines, 1, 'Available commands:')
        end

        return contentLines
    end

    --[[--
    Gets a command instance by its operation or the default help command.

    To avoid any confusions, although loaded by an operation, the return
    command is an instance of the Command class, so that's why this method is
    prefixed with getCommand.

    @tparam string operation The operation associated with the command

    @treturn Command The command instance or the default help command
    ]]
    function CommandsHandler:getCommandOrDefault(operation)
        local command = operation and self.operations[operation] or nil

        if command and command.callback then
            return command
        end

        return self.operations['help']
    end

    --[[--
    This method is responsible for handling the command that was triggered
    by the user, parsing the arguments and invoking the callback that was
    registered for the operation.

    @local

    @tparam string commandArg The full command argument
    ]]
    function CommandsHandler:handle(commandArg)
        self:maybeInvokeCallback(
            self:parseOperationAndArguments(
                self:parseArguments(commandArg)
            )
        )
    end

    --[[--
    This method is responsible for invoking the callback that was registered
    for the operation, if it exists, or the default one otherwise.

    But before invoking the callback, it validates the arguments that were
    passed to the operation in case the command has an arguments validator.
    
    @local

    @tparam string operation The operation that was triggered
    @tparam table args The arguments that were passed to the operation
    ]]
    function CommandsHandler:maybeInvokeCallback(operation, args)
        local command = self:getCommandOrDefault(operation)

        local validationResult = command:validateArgs(self.__.arr:unpack(args))

        if validationResult ~= 'valid' then
            self.__.output:out(validationResult)
            return
        end

        command.callback(self.__.arr:unpack(args))
    end

    --[[--
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

    @local

    @tparam string input The full command argument

    @treturn table[string] A list of strings representing the arguments
    ]]
    function CommandsHandler:parseArguments(input)
        if not input then return {} end

        local result = {}
        local inDoubleQuotes, inSingleQuotes = false, false
        local currentWord = ""
    
        for i = 1, #input do
            local char = input:sub(i, i)
            if char == "'" and not inDoubleQuotes then
                inSingleQuotes = not inSingleQuotes
            elseif char == '"' and not inSingleQuotes then
                inDoubleQuotes = not inDoubleQuotes
            elseif char == " " and not (inSingleQuotes or inDoubleQuotes) then
                if currentWord ~= "" then
                    table.insert(result, currentWord)
                    currentWord = ""
                end
            else
                currentWord = currentWord .. char
            end
        end
    
        if currentWord ~= "" then
            table.insert(result, currentWord)
        end
    
        return result
    end

    --[[--
    This method selects the first command argument as the operation and the
    subsequent arguments as the operation arguments.

    Note that args can be empty, so there's no operation and no arguments.

    Still, if the size of args is 1, it means there's an operation and no
    arguments. If the size is greater than 1, the first argument is the
    operation and the rest are the arguments.

    @local

    @tparam table[string] args The arguments that were passed to the operation

    @treturn[1] string The operation that was triggered
    @treturn[1] table[string] The arguments that were passed to the operation
    ]]
    function CommandsHandler:parseOperationAndArguments(args)
        if not args or #args == 0 then
            return nil, {}
        elseif #args == 1 then
            return args[1], {}
        else
            -- the subset of the args table from the second element to the last
            -- represents the arguments
            return args[1], {self.__.arr:unpack(args, 2)}
        end
    end

    --[[--
    Prints the help content to the chat frame.

    @local
    ]]
    function CommandsHandler:printHelp()
        local helpContent = self:buildHelpContent()

        if helpContent and (#helpContent > 0) then self.__.output:out(helpContent) end
    end

    --[[--
    Register the main Stormwind Library command callback that will then redirect
    the command to the right operation callback.

    In terms of how the library was designed, this is the only real command
    handler and serves as a bridge between World of Warcraft command system
    and the addon itself.

    @local
    ]]
    function CommandsHandler:register()
        if (not SlashCmdList) or (not self.__.addon.command) then return end

        local lowercaseCommand = string.lower(self.__.addon.command)
        local uppercaseCommand = string.upper(self.__.addon.command)

        -- stores a global reference to the addon command
        self.slashCommand = '/' .. lowercaseCommand

        _G['SLASH_' .. uppercaseCommand .. '1'] = self.slashCommand
        SlashCmdList[uppercaseCommand] = function (args)
            self:handle(args)
        end
    end
-- end of CommandsHandler

-- sets the unique library commands handler instance
self.commands = CommandsHandler.__construct()
self.commands:register()

-- allows CommandHandler to be instantiated, very useful for testing
self:addClass('CommandsHandler', CommandsHandler)