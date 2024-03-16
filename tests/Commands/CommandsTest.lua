TestCommand = {}
    -- @covers Command:__construct()
    function TestCommand:testInstantiate()
        local command = __:new('Command')

        lu.assertNotIsNil(command)
    end
-- end of TestCommand