TestStr = {}
    -- @covers Str:split()
    function TestStr:testCanSplit()
        local function execution(value, separator, expectedOutput)
            lu.assertEquals(__.str:split(value, separator), expectedOutput)
        end

        execution('', '.', {})
        execution('test', '.', {'test'})
        execution('test-a.test-b.test-c', '.', {'test-a', 'test-b', 'test-c'})
    end
-- end of TestStr