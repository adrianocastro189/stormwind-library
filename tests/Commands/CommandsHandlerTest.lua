TestCommandsHandler = {}
    -- @covers StormwindLibrary:add()
    function TestCommandsHandler:testAdd()
        local handler = __.commands

        local command = __
            :new('Command')
            :setOperation('test-operation')
            :setCallback('test-callback')

        handler:add(command)

        lu.assertEquals('test-callback', handler.operations['test-operation'])
    end

    -- @covers StormwindLibrary.commands
    function TestCommandsHandler:testGetCommandsHandler()
        local handler = __.commands

        lu.assertIsTable(handler)
        lu.assertIsTable(handler.operations)
    end
-- end of TestTarget