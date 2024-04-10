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

    -- @covers Output:isTestingMode()
    function TestOutput:testIsTestingMode()
        local output = __:new('Output')

        lu.assertFalse(output:isTestingMode())

        output:setTestingMode()

        lu.assertTrue(output:isTestingMode())
    end

    -- @covers Output:out()
    function TestOutput:testOut()
        local output = __:new('Output')

        local printedMessage = nil

        function output:getFormattedMessage(message) return 'formatted-' .. message end
        function output:print(message) printedMessage = message end

        output:out('test-message')

        lu.assertEquals('formatted-test-message', printedMessage)
        lu.assertIsNil(output.history)
    end

    -- @covers Output:out()
    function TestOutput:testOutInTestingMode()
        local output = __:new('Output')

        function output:print(message) error('this method should not be called') end

        output:setTestingMode()

        output:out('test-message')

        lu.assertEquals({'test-message'}, output.history)
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

    -- @covers Output:printed()
    function TestOutput:testPrinted()
        local output = __:new('Output')

        lu.assertIsFalse(output:printed('test-message'))

        output:setTestingMode()

        output:out('test-message-a')
        output:out('test-message-b')

        lu.assertTrue(output:printed('test-message-a'))
        lu.assertTrue(output:printed('test-message-b'))
        lu.assertIsFalse(output:printed('test-message-c'))
    end

    -- @covers Output:setTestingMode()
    function TestOutput:testSetTestingMode()
        local output = __:new('Output')

        lu.assertEquals('out', output.mode)
        lu.assertIsNil(output.history)

        output:setTestingMode()

        lu.assertEquals('test', output.mode)
        lu.assertEquals({}, output.history)
    end
-- end of TestOutput