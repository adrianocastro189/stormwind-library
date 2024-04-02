TestCommand = BaseTestClass:new()
    -- @covers Command:setCallback()
    -- @covers Command:setDescription()
    -- @covers Command:setOperation()
    function TestCommand:testChainedSetters()
        local command = __:new('Command')
        
        command
            :setCallback('test-callback')
            :setDescription('test-description')
            :setOperation('test-operation')

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
-- end of TestCommand