TestStr = {}
    -- @covers Str:isEmpty()
    -- @covers Str:isNotEmpty()
    function TestStr:testIsEmpty()
        local function execution(value, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:isEmpty(value))
            lu.assertEquals(not expectedOutput, __.str:isNotEmpty(value))
        end

        execution(nil, true)
        execution('', true)
        execution(' ', true)
        execution('a', false)
        execution(' a', false)
        execution('a ', false)
    end

    -- @covers Str:isWrappedBy()
    function TestStr:testIsWrappedBy()
        local function execution(value, wrapper, endWrapper, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:isWrappedBy(value, wrapper, endWrapper))
        end

        execution('<a>', '<', '>', true)
        execution('(a>', '(', ')', false)
        execution('""', '"', nil, true)
        execution('"a"', '"', nil, true)
        execution("'a'", "'", nil, true)
        execution("''", "'", nil, true)
        execution('"a', '"', nil, false)
        execution('a', '', nil, false)

        -- edge cases
        execution('a', 'a', nil, false)
        execution('', '', '', false)
        execution(nil, '', '', false)
        execution('', nil, '', false)
        execution(nil, nil, nil, false)
    end

    -- @covers Str:removeWrappers()
    function TestStr:testRemoveWrappers()
        local function execution(value, wrapper, endWrapper, expectedOutput)
            lu.assertEquals(expectedOutput, __.str:removeWrappers(value, wrapper, endWrapper))
        end

        execution('<a>', '<', '>', 'a')
        execution('_(a)_', '_(', ')_', 'a')
        execution('""', '"', nil, '')
        execution('"a"', '"', nil, 'a')
        execution("'a'", "'", nil, 'a')
        execution("''", "'", nil, '')
        execution('"a', '"', nil, '"a')
        execution('a', '', nil, 'a')

        -- won't remove internal wrappers
        execution('"a"b"c"', '"', nil, 'a"b"c')

        -- edge cases
        execution('a', 'a', nil, 'a')
        execution('', '', '', '')
        execution(nil, '', '', nil)
        execution('', nil, '', '')
        execution(nil, nil, nil, nil)
    end

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