TestCommand = {}
    -- @covers Command:setAction()    
    -- @covers Command:setCallback()
    -- @covers Command:setName()
    function TestCommand:testChainedSetters()
        local command = __:new('Command')
        
        command
            :setName('test-name')
            :setAction('test-action')
            :setCallback('test-callback')

        lu.assertEquals('test-name', command.name)
        lu.assertEquals('test-action', command.action)
        lu.assertEquals('test-callback', command.callback)
    end

    -- @covers Command:__construct()
    function TestCommand:testInstantiate()
        local command = __:new('Command')

        lu.assertNotIsNil(command)
    end
-- end of TestCommand