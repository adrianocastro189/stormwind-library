-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestCommand = BaseTestClass:new()
    -- @covers Command:setCallback()
    -- @covers Command:setDescription()
    -- @covers Command:setOperation()
    function TestCommand:testChainedSetters()
        local command = __:new('Command')
        
        command
            :setArgsValidator('test-args-validator')
            :setCallback('test-callback')
            :setDescription('test-description')
            :setOperation('test-operation')

        lu.assertEquals('test-args-validator', command.argsValidator)
        lu.assertEquals('test-callback', command.callback)
        lu.assertEquals('test-description', command.description)
        lu.assertEquals('test-operation', command.operation)
    end

    -- @covers Command:getHelpContent()
    function TestCommand:testGetHelpContent()
        local function execution(command, expectedOutput)
            lu.assertEquals(expectedOutput, command:getHelpContent())
        end

        local emptyCommand = __:new('Command')
        local commandWithoutDescription = __:new('Command'):setOperation('test-operation')
        local completeCommand = __:new('Command'):setOperation('test-operation'):setDescription('test-description')

        execution(emptyCommand, nil)
        execution(commandWithoutDescription, 'test-operation')
        execution(completeCommand, 'test-operation - test-description')
    end

    -- @covers Command:__construct()
    function TestCommand:testInstantiate()
        local command = __:new('Command')

        lu.assertNotIsNil(command)
    end

    -- @covers Command:validateArgs()
    function TestCommand:testValidateArgs()
        local function execution(validator, expectedOutput)
            local command = __:new('Command')

            command:setArgsValidator(validator)

            lu.assertEquals(expectedOutput, command:validateArgs())
        end

        -- no validator
        execution(nil, 'valid')

        -- validator returning invalid
        execution(function() return 'invalid' end, 'invalid')
    end

    -- @covers Command:validateArgs()
    function TestCommand:testValidateArgsWithMultipleParameters()
        local command = __:new('Command')

        -- makes sure the arguments are being passed to the validator
        command:setArgsValidator(function(arg1, arg2)
            command.arg1 = arg1
            command.arg2 = arg2
        end)

        command:validateArgs('arg1', 'arg2')

        lu.assertEquals('arg1', command.arg1)
        lu.assertEquals('arg2', command.arg2)
    end
-- end of TestCommand