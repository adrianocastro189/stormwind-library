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

    -- @covers StormwindLibrary:parseArguments()
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
    end
-- end of TestTarget