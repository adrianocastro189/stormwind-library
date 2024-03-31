TestStr = {}
    -- @covers Str:replaceAll()
    function TestStr:testReplaceAll()
        local function execution(value, find, replace, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:replaceAll(value, find, replace))
        end

        execution('', '', '', '')
        execution('', 'a', 'b', '')
        execution('a', 'a', 'b', 'b')
        execution('aabb', 'a', 'b', 'bbbb')
        execution('aa.bb', '.', '_', 'aa_bb')
        execution('aa(bb)', '(', '-', 'aa-bb)')
        execution('aa(bb)', ')', '-', 'aa(bb-')
        execution('a word', 'word', 'phrase', 'a phrase')
        execution('this is a test.', 'test.', 'result', 'this is a result')
        execution('test[with square brackets', '[', ' ', 'test with square brackets')
        execution('test]with square brackets', ']', ' ', 'test with square brackets')
        execution('test\\with backslash', '\\', ' ', 'test with backslash')
        execution('test with "double quotes"', '"', '', 'test with double quotes')
        execution("test with 'quotes'", "'", '', 'test with quotes')
    end

    -- @covers Str:split()
    function TestStr:testSplit()
        local function execution(value, separator, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:split(value, separator))
        end

        execution('', '.', {})
        execution('test', '.', {'test'})
        execution('test-a.test-b.test-c', '.', {'test-a', 'test-b', 'test-c'})
        execution('test-a test-b test-c', ' ', {'test-a', 'test-b', 'test-c'})
    end

    -- @covers Str:trim()
    function TestStr:testTrim()
        local function execution(value, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:trim(value))
        end

        execution(nil, nil)
        execution('', '')
        execution(' ', '')
        execution('  ', '')
        execution('    ', '')
        execution('a', 'a')
        execution(' a', 'a')
        execution('a ', 'a')
        execution(' a ', 'a')
        execution('  a  ', 'a')
        execution('  a b  ', 'a b')
        execution('  a  b  ', 'a  b')
    end
-- end of TestStr