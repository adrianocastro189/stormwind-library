TestOutput = {}
    -- @covers Output:__construct()
    function TestOutput:testInstantiate()
        lu.assertNotIsNil(__:new('Output'))
    end

    -- @covers Output:getFormattedMessage()
    function TestOutput:testGetFormattedMessage()
        lu.assertEquals('TestSuite | test-message', __.output:getFormattedMessage('test-message'))
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