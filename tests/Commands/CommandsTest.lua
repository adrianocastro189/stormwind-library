TestCommand = {}
    -- @covers Command:setCallback()
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

    -- @covers Command:__construct()
    function TestCommand:testInstantiate()
        local command = __:new('Command')

        lu.assertNotIsNil(command)
    end
-- end of TestCommand