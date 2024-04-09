TestOutput = BaseTestClass:new()
    -- @covers Output:color()
    function TestOutput:testColor()
        local function execution(value, color, primaryColor, expectedOutput)
            __.addon.colors.primary = primaryColor

            lu.assertEquals(expectedOutput, __.output:color(value, color))
        end

        execution('test', nil, nil, 'test')
        execution('test', nil, 'FFFFFF', '|cfffffffftest|r')
        execution('test', 'FFFFFF', nil, '|cfffffffftest|r')
        execution('test', 'FFFFFF', '000000', '|cfffffffftest|r')
    end

    -- @covers Output:__construct()
    function TestOutput:testInstantiate()
        local instance = __:new('Output')

        lu.assertNotNil(instance)
        lu.assertEquals('out', instance.mode)
    end

    -- @covers Output:getFormattedMessage()
    function TestOutput:testGetFormattedMessage()
        local output = __:new('Output')

        function output:color(value) return 'colored-' .. value end

        lu.assertEquals('colored-TestSuite | test-message', output:getFormattedMessage('test-message'))
    end

    -- @covers Output:out()
    function TestOutput:testOut()
        local output = __:new('Output')

        function output:getFormattedMessage(message) return 'formatted-' .. message end
        function output:print(message) lu.assertEquals('formatted-test-message', message) end

        output:out('test-message')
    end

    -- @covers Output:print()
    function TestOutput:testPrint()
        local originalPrint = print

        local printedMessage = nil
        print = function(message) printedMessage = message end

        lu.assertIsNil(printedMessage)

        __.output:print('test')

        print = originalPrint

        lu.assertEquals('test', printedMessage)
    end

    -- @covers Output:setTestingMode()
    function TestOutput:testSetTestingMode()
        lu.assertEquals('out', __.output.mode)
        lu.assertIsNil(__.output.history)

        __.output:setTestingMode()

        lu.assertEquals('test', __.output.mode)
        lu.assertEquals({}, __.output.history)
    end
-- end of TestOutput