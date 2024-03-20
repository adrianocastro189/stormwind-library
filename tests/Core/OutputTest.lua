TestOutput = {}
    -- @covers Output:color()
    function TestOutput:testColor()
        local function execution(value, color, primaryColor, expectedOutput)
            local originalPrimaryColor = __.addon.colors.primary

            __.addon.colors.primary = primaryColor

            lu.assertEquals(expectedOutput, __.output:color(value, color))

            __.addon.colors.primary = originalPrimaryColor
        end

        execution('test', nil, nil, 'test')
        execution('test', nil, 'FFFFFF', '|cfffffffftest|r')
        execution('test', 'FFFFFF', nil, '|cfffffffftest|r')
        execution('test', 'FFFFFF', '000000', '|cfffffffftest|r')
    end

    -- @covers Output:__construct()
    function TestOutput:testInstantiate()
        lu.assertNotIsNil(__:new('Output'))
    end

    -- @covers Output:getFormattedMessage()
    function TestOutput:testGetFormattedMessage()
        local output = __:new('Output')

        function output:color(value) return 'colored-' .. value end

        lu.assertEquals('colored-TestSuite | test-message', output:getFormattedMessage('test-message'))
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
-- end of TestOutput