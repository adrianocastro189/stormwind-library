TestCommandsHandler = BaseTestClass:new()
    -- @covers CommandsHandler:add()
    function TestCommandsHandler:testAdd()
        local handler = __.commands

        local command = __
            :new('Command')
            :setOperation('test-operation')
            :setCallback('test-callback')

        handler:add(command)

        lu.assertEquals(command, handler.operations['test-operation'])
    end

    -- @covers CommandsHandler:addHelpOperation()
    function TestCommandsHandler:testAddHelpOperation()
        local handler = __:new('CommandsHandler')

        handler:addHelpOperation()

        lu.assertNotNil(handler.operations['help'])
    end

    -- @covers CommandsHandler:buildHelpContent()
    function TestCommandsHandler:testBuildHelpContent()
        local handler = __:new('CommandsHandler')
        handler.slashCommand = '/test'

        lu.assertEquals({}, handler:buildHelpContent())

        local commandA = __
            :new('Command')
            :setOperation('test-operation-a')
            :setDescription('test-callback-a-description')

        local commandB = __
            :new('Command')
            :setOperation('test-operation-b')
            :setDescription('test-callback-b-description')

        local commandC = __
            :new('Command')
            :setOperation('test-operation-c')

        local helpCommand = __
            :new('Command')
            :setOperation('help')

        handler:add(commandC)
        handler:add(commandA)
        handler:add(helpCommand)
        handler:add(commandB)

        lu.assertEquals({
            'Available commands:',
            '/test test-operation-a - test-callback-a-description',
            '/test test-operation-b - test-callback-b-description',
            '/test test-operation-c'
        }, handler:buildHelpContent())
    end

    -- @covers StormwindLibrary.commands
    function TestCommandsHandler:testGetCommandsHandler()
        local handler = __.commands

        lu.assertIsTable(handler)
        lu.assertIsTable(handler.operations)
    end

    -- @covers CommandsHandler:getCommandOrDefault()
    function TestCommandsHandler:testGetCommandOrDefault()
        local function execution(operation, command, expectedResult)
            if command then
                __.commands.operations[operation] = command
            end

            local result = __.commands:getCommandOrDefault(operation)

            lu.assertEquals(expectedResult, result)
        end

        local helpCommand = 'test-help-command'
        __.commands.operations['help'] = helpCommand

        -- no operation
        execution(nil, nil, helpCommand)

        -- operation with no command associated
        execution('test-operation', nil, helpCommand)

        -- command with no callback
        execution('test-operation', __:new('Command'), helpCommand)

        -- command with callback
        local commandWithCallback = __:new('Command'):setCallback('test-callback')
        execution('test-operation', commandWithCallback, commandWithCallback)
    end

    -- @covers CommandsHandler:handle()
    function TestCommandsHandler:testHandle()
        local invokedArgs = nil

        local function callback(arg1, arg2, arg3) invokedArgs = {arg1, arg2, arg3} end

        local command = __
            :new('Command')
            :setOperation('test-operation')
            :setCallback(callback)

        local handler = __:new('CommandsHandler')

        handler:add(command)

        lu.assertIsNil(invokedArgs)

        handler:handle('test-operation arg1 arg2 arg3')

        lu.assertEquals({'arg1', 'arg2', 'arg3'}, invokedArgs)
    end

    --[[
    @covers StormwindLibrary:handle()

    This test just makes sure an invalid operation won't throw errors
    ]]
    function TestCommandsHandler:testHandleWithInvalidOperation()
        __:new('CommandsHandler'):handle('invalid-operation')
    end

    -- @covers CommandsHandler:parseArguments()
    function TestCommandsHandler:testParseArguments()
        local function execution(value, expectedOutput)
            local output = __.commands:parseArguments(value)

            lu.assertEquals(expectedOutput, output)
        end

        execution(nil, {})
        execution('', {})
        execution('    ', {})
        execution('test', {'test'})
        execution('test with multiple words', {'test', 'with', 'multiple', 'words'})
        execution('test   with   multiple    spaces', {'test', 'with', 'multiple', 'spaces'})
        execution('"test with" "multiple words in double quotes"', {'test with', 'multiple words in double quotes'})
        execution("'test with' 'multiple words in quotes'", {'test with', 'multiple words in quotes'})
        execution("\"name with ' single quotes\"", {"name with ' single quotes"})
        execution("\"name with multiple 'single quotes'\"", {"name with multiple 'single quotes'"})
        execution("'\"name wrapped in double quotes\"'", {"\"name wrapped in double quotes\""})
        execution('"name 1" "name 2"', {"name 1", "name 2"})
    end    

    -- @covers CommandsHandler:parseOperationAndArguments()
    function TestCommandsHandler:testParseOperationAndArguments()
        local function execution(args, expectedOperation, expectedArguments)
            local operation, arguments = __.commands:parseOperationAndArguments(args)

            lu.assertEquals(expectedOperation, operation)
            lu.assertEquals(expectedArguments, arguments)
        end

        execution(nil, nil, {})
        execution({}, nil, {})
        execution({'test'}, 'test', {})
        execution({'test', 'with', 'multiple', 'args'}, 'test', {'with', 'multiple', 'args'})
    end

    -- @covers CommandsHandler:printHelp()
    function TestCommandsHandler:testPrintHelp()
        local function execution(helpContent, shouldOutput)
            local handler = __:new('CommandsHandler')

            function handler:buildHelpContent() return helpContent end

            local outputInvoked = false

            function __.output:out() outputInvoked = true end

            handler:printHelp()

            lu.assertEquals(shouldOutput, outputInvoked)
        end

        execution(nil, false)
        execution({}, false)
        execution({'command-a'}, true)
    end

    -- @covers CommandsHandler:register()
    function TestCommandsHandler:testRegister()
        local function execution(command, expectedGlobalSlashCommandIndex, expectedSlashCommand, expectedSlashCmdListIndex)
            local currentSlashCmdList = SlashCmdList 

            -- mocks the properties for this test
            SlashCmdList = {}
            __.addon.command = command

            lu.assertIsNil(__.commands.slashCommand)

            __.commands:register()

            if expectedGlobalSlashCommandIndex then
                lu.assertNotIsNil(__.arr:get(_G, expectedGlobalSlashCommandIndex))
                lu.assertEquals(expectedSlashCommand, _G[expectedGlobalSlashCommandIndex])
                lu.assertEquals(expectedSlashCommand, __.commands.slashCommand)
                lu.assertIsFunction(SlashCmdList[expectedSlashCmdListIndex])
            end

            SlashCmdList = currentSlashCmdList
        end

        execution(nil, nil, nil, nil)
        execution('test', 'SLASH_TEST1', '/test', 'TEST')
    end
-- end of TestCommandsHandler