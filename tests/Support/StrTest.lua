TestStr = {}
    -- @covers Str:split()
    function TestStr:testCanSplit()
        local function execution(value, separator, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:split(value, separator))
        end

        execution('', '.', {})
        execution('test', '.', {'test'})
        execution('test-a.test-b.test-c', '.', {'test-a', 'test-b', 'test-c'})
        execution('test-a test-b test-c', ' ', {'test-a', 'test-b', 'test-c'})
    end
-- end of TestStr