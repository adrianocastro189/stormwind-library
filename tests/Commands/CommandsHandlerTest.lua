TestCommandsHandler = BaseTestClass:new()

-- @covers CommandsHandler:add()
TestCase.new()
    :setName('add')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        local handler = __.commands
        local command = __
            :new('Command')
            :setOperation('test-operation')
            :setCallback('test-callback')

        handler:add(command)   
        lu.assertEquals(command, handler.operations['test-operation'])
    end)
    :register()

-- @covers CommandsHandler:addOperation()
TestCase.new()
    :setName('addOperation')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        local handler = __:new('CommandsHandler')
        handler:addOperation('test-operation', 'test-description', 'test-callback')
        lu.assertNotNil(handler.operations['test-operation'])
    end)
    :register()

-- @covers CommandsHandler:buildHelpContent()
TestCase.new()
    :setName('buildHelpContent')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
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
    end)
    :register()

-- @covers StormwindLibrary.commands
TestCase.new()
    :setName('commands')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        local handler = __.commands
        lu.assertIsTable(handler)
        lu.assertIsTable(handler.operations)
    end)
    :register()

-- @covers CommandsHandler:addHelpOperation()
TestCase.new()
    :setName('default operations')
    :setTestClass(TestCommandsHandler)
    :setExecution(function(data)
        local handler = Spy
            .new(__:new('CommandsHandler'))
            :mockMethod('addOperation')

        handler[data.method](handler)

        local method = handler:getMethod('addOperation')

        method:assertCalledOnce()
        lu.assertEquals(data.expectedOperation, method.args[1][1])
        lu.assertEquals(data.expectedDescription, method.args[1][2])
        lu.assertIsFunction(method.args[1][3])
    end)
    :setScenarios({
        ['get'] = {
            method = 'addGetOperation',
            expectedOperation = 'get',
            expectedDescription = 'Gets the value of a setting identified by its id',
        },
        ['help'] = {
            method = 'addHelpOperation',
            expectedOperation = 'help',
            expectedDescription = 'Shows the available operations for this command',
        },
    })
    :register()

-- @covers CommandsHandler:getCommandOrDefault()
TestCase.new()
    :setName('getCommandOrDefault')
    :setTestClass(TestCommandsHandler)
    :setExecution(function(data)
        __.commands.operations['help'] = data.defaultCommand

        if data.command then
            __.commands.operations[data.operation] = data.command
        end
        local result = __.commands:getCommandOrDefault(data.operation)
        lu.assertEquals(data.expectedResult, result)
    end)
    :setScenarios({
        ['no operation'] = {
            operation = nil,
            command = nil,
            defaultCommand = 'test-help-command',
            expectedResult = 'test-help-command',
        },
        ['operation with no command associated'] = {
            operation = 'test-operation',
            command = nil,
            defaultCommand = 'test-help-command',
            expectedResult = 'test-help-command',
        },
        ['command with no callback'] = function () return {
            operation = 'test-operation',
            command = __:new('Command'),
            defaultCommand = 'test-help-command',
            expectedResult = 'test-help-command',
        } end,
        ['command with callback'] = function ()
            local commandWithCallback = __:new('Command'):setCallback('test-callback')
            return {
                operation = 'test-operation',
                command = commandWithCallback,
                defaultCommand = 'test-help-command',
                expectedResult = commandWithCallback,
            }
        end,
    })
    :register()

-- @covers CommandsHandler get operation
TestCase.new()
    :setName('get operation')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        local handler = __:new('CommandsHandler')

        handler.__.settings = Spy
            .new(handler.__)
            :mockMethod('printValue')

        handler:addGetOperation()

        local callback = handler.operations['get'].callback

        callback('test')

        handler.__.settings:getMethod('printValue'):assertCalledOnceWith('test')
    end)
    :register()

-- @covers CommandsHandler:handle()
TestCase.new()
    :setName('handle')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
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
    end)
    :register()

-- @covers CommandsHandler:handle()
TestCase.new()
    :setName('handle with invalid operation')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        __:new('CommandsHandler'):handle('invalid-operation')
    end)
    :register()

-- @covers CommandsHandler:maybeInvokeCallback()
TestCase.new()
    :setName('maybeInvokeCallback')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        local handler = __:new('CommandsHandler')
        local command = Spy.new(__:new('Command'))
        command:mockMethod('validateArgs', function() return 'invalid arguments' end)
        handler.getCommandOrDefault = function() return command end
        handler:maybeInvokeCallback('test-operation', {})
        lu.assertIsTrue(__.output:printed('invalid arguments'))
        command:getMethod('validateArgs'):assertCalledOnce()
    end)
    :register()

-- @covers CommandsHandler:maybeInvokeCallback()
TestCase.new()
    :setName('maybeInvokeCallback with valid args')
    :setTestClass(TestCommandsHandler)
    :setExecution(function()
        local command = Spy
            .new(__:new('Command'))
            :mockMethod('validateArgs', function() return 'valid' end)

        local handler = Spy
            .new(__:new('CommandsHandler'))
            :mockMethod('getCommandOrDefault', function() return command end)

        -- makes sure the arguments are properly unpacked for the callback phase
        command.callback = function(arg1, arg2, arg3)
            command.callbackArg1 = arg1
            command.callbackArg2 = arg2
            command.callbackArg3 = arg3
        end

        handler:maybeInvokeCallback('test-operation', {'test-arg1', 'test-arg2', 'test-arg3'})

        -- command:getMethod('callback'):assertCalledOnceWith('test-arg1', 'test-arg2', 'test-arg3')
        command:getMethod('validateArgs'):assertCalledOnceWith('test-arg1', 'test-arg2', 'test-arg3')

        lu.assertEquals('test-arg1', command.callbackArg1)
        lu.assertEquals('test-arg2', command.callbackArg2)
        lu.assertEquals('test-arg3', command.callbackArg3)
    end)
    :register()

-- @covers CommandsHandler:parseArguments()
TestCase.new()
    :setName('parseArguments')
    :setTestClass(TestCommandsHandler)
    :setExecution(function(data)
        local output = __.commands:parseArguments(data.value)
        lu.assertEquals(data.expectedOutput, output)
    end)
    :setScenarios({
        ['nil'] = { value = nil, expectedOutput = {} },
        ['empty string'] = { value = '', expectedOutput = {} },
        ['multiple spaces'] = { value = '    ', expectedOutput = {} },
        ['single word'] = { value = 'test', expectedOutput = {'test'} },
        ['multiple words'] = { value = 'test with multiple words', expectedOutput = {'test', 'with', 'multiple', 'words'} },
        ['multiple spaces between words'] = { value = 'test   with   multiple    spaces', expectedOutput = {'test', 'with', 'multiple', 'spaces'} },
        ['double quotes'] = { value = '"test with" "multiple words in double quotes"', expectedOutput = {'test with', 'multiple words in double quotes'} },
        ['single quotes'] = { value = "'test with' 'multiple words in quotes'", expectedOutput = {'test with', 'multiple words in quotes'} },
        ['single quotes inside double quotes'] = { value = "\"name with ' single quotes\"", expectedOutput = {"name with ' single quotes"} },
        ['multiple single quotes inside double quotes'] = { value = "\"name with multiple 'single quotes'\"", expectedOutput = {"name with multiple 'single quotes'"} },
        ['double quotes inside single quotes'] = { value = "'\"name wrapped in double quotes\"'", expectedOutput = {"\"name wrapped in double quotes\""} },
        ['multiple double quotes'] = { value = '"name 1" "name 2"', expectedOutput = {"name 1", "name 2"} },
    })
    :register()

-- @covers CommandsHandler:parseOperationAndArguments()
TestCase.new()
    :setName('parseOperationAndArguments')
    :setTestClass(TestCommandsHandler)
    :setExecution(function(data)
        local operation, arguments = __.commands:parseOperationAndArguments(data.args)
        lu.assertEquals(data.expectedOperation, operation)
        lu.assertEquals(data.expectedArguments, arguments)
    end)
    :setScenarios({
        ['nil'] = { args = nil, expectedOperation = nil, expectedArguments = {} },
        ['empty'] = { args = {}, expectedOperation = nil, expectedArguments = {} },
        ['single argument'] = { args = {'test'}, expectedOperation = 'test', expectedArguments = {} },
        ['multiple arguments'] = { args = {'test', 'with', 'multiple', 'args'}, expectedOperation = 'test', expectedArguments = {'with', 'multiple', 'args'} },
    })
    :register()

-- @covers CommandsHandler:printHelp()
TestCase.new()
    :setName('printHelp')
    :setTestClass(TestCommandsHandler)
    :setExecution(function(data)
        local handler = Spy
            .new(__:new('CommandsHandler'))
            :mockMethod('buildHelpContent', function() return data.helpContent end)

        __.output = Spy
            .new(__.output)
            :mockMethod('out')

        handler:printHelp()

        __.output:getMethod('out'):assertCalledOrNot(data.shouldOutput)
    end)
    :setScenarios({
        ['nil'] = { helpContent = nil, shouldOutput = false },
        ['empty'] = { helpContent = {}, shouldOutput = false },
        ['with content'] = { helpContent = {'command-a'}, shouldOutput = true },
    })
    :register()

-- @covers CommandsHandler:register()
TestCase.new()
    :setName('register')
    :setTestClass(TestCommandsHandler)
    :setExecution(function(data)
        local currentSlashCmdList = SlashCmdList

        -- mocks the properties for this test
        SlashCmdList = {}
        __.addon.command = data.command

        lu.assertIsNil(__.commands.slashCommand)

        __.commands:register()

        if data.expectedGlobalSlashCommandIndex then
            lu.assertNotIsNil(__.arr:get(_G, data.expectedGlobalSlashCommandIndex))
            lu.assertEquals(data.expectedSlashCommand, _G[data.expectedGlobalSlashCommandIndex])
            lu.assertEquals(data.expectedSlashCommand, __.commands.slashCommand)
            lu.assertIsFunction(SlashCmdList[data.expectedSlashCmdListIndex])
        end

        SlashCmdList = currentSlashCmdList
    end)
    :setScenarios({
        ['nil'] = {
            command = nil,
            expectedGlobalSlashCommandIndex = nil,
            expectedSlashCommand = nil,
            expectedSlashCmdListIndex = nil
        },
        ['test'] = {
            command = 'test',
            expectedGlobalSlashCommandIndex = 'SLASH_TEST1',
            expectedSlashCommand = '/test',
            expectedSlashCmdListIndex = 'TEST'
        },
    })
    :register()
-- end of TestCommandsHandler