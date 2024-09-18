TestStr = BaseTestClass:new()

-- @covers Str:isEmpty()
-- @covers Str:isNotEmpty()
TestCase.new()
    :setName('isEmpty')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:isEmpty(data.value))
        lu.assertEquals(not data.expectedOutput, __.str:isNotEmpty(data.value))
    end)
    :setScenarios({
        ['nil'] = {
            value = nil,
            expectedOutput = true,
        },
        ['empty string'] = {
            value = '',
            expectedOutput = true,
        },
        ['whitespace string'] = {
            value = ' ',
            expectedOutput = true,
        },
        ['single character'] = {
            value = 'a',
            expectedOutput = false,
        },
        ['starts with empty space'] = {
            value = ' a',
            expectedOutput = false,
        },
        ['ends with empty space'] = {
            value = 'a ',
            expectedOutput = false,
        },
    })
    :register()

-- @covers Str:isQuoted()
TestCase.new()
    :setName('isQuoted')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:isQuoted(data.value))
    end)
    :setScenarios({
        ['nil'] = {
            value = nil,
            expectedOutput = false,
        },
        ['empty string'] = {
            value = '',
            expectedOutput = false,
        },
        ['whitespace string'] = {
            value = ' ',
            expectedOutput = false,
        },
        ['single character'] = {
            value = 'a',
            expectedOutput = false,
        },
        ['double quotes'] = {
            value = '"a"',
            expectedOutput = true,
        },
        ['single quotes'] = {
            value = "'a'",
            expectedOutput = true,
        },
        ['empty double quotes'] = {
            value = '""',
            expectedOutput = true,
        },
        ['empty single quotes'] = {
            value = "''",
            expectedOutput = true,
        },
        ['unmatched double quotes'] = {
            value = '"a',
            expectedOutput = false,
        },
        ['unmatched single quotes'] = {
            value = "'a",
            expectedOutput = false,
        },
    })
    :register()

-- @covers Str:isWrappedBy()
TestCase.new()
    :setName('isWrappedBy')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:isWrappedBy(data.value, data.wrapper, data.endWrapper))
    end)
    :setScenarios({
        ['<a>'] = { value = '<a>', wrapper = '<', endWrapper = '>', expectedOutput = true, },
        ['(a>'] = { value = '(a>', wrapper = '(', endWrapper = ')', expectedOutput = false, },
        ['""'] = { value = '""', wrapper = '"', endWrapper = nil, expectedOutput = true, },
        ['"a"'] = { value = '"a"', wrapper = '"', endWrapper = nil, expectedOutput = true, },
        ["'a'"] = { value = "'a'", wrapper = "'", endWrapper = nil, expectedOutput = true, },
        ["''"] = { value = "''", wrapper = "'", endWrapper = nil, expectedOutput = true, },
        ['"a'] = { value = '"a', wrapper = '"', endWrapper = nil, expectedOutput = false, },
        ['a'] = { value = 'a', wrapper = '', endWrapper = nil, expectedOutput = false, },
        ['e. case - a'] = { value = 'a', wrapper = 'a', endWrapper = nil, expectedOutput = false, },
        ['e. case - empty'] = { value = '', wrapper = '', endWrapper = '', expectedOutput = false, },
        ['e. case - nil'] = { value = nil, wrapper = '', endWrapper = '', expectedOutput = false, },
        ['e. case - endWrapper empty'] = { value = '', wrapper = nil, endWrapper = '', expectedOutput = false, },
        ['e. case - all nil'] = { value = nil, wrapper = nil, endWrapper = nil, expectedOutput = false, },
    })
    :register()

-- @covers Str:removeQuotes()
TestCase.new()
    :setName('removeQuotes')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:removeQuotes(data.value))
    end)
    :setScenarios({
        ['nil'] = { value = nil, expectedOutput = nil },
        ['empty'] = { value = '', expectedOutput = '' },
        ['whitespace'] = { value = ' ', expectedOutput = ' ' },
        ['single character'] = { value = 'a', expectedOutput = 'a' },
        ['quoted character'] = { value = '"a"', expectedOutput = 'a' },
        ['single quoted character'] = { value = "'a'", expectedOutput = 'a' },
        ['empty double quotes'] = { value = '""', expectedOutput = '' },
        ['empty single quotes'] = { value = "''", expectedOutput = '' },
        ['escaped single quotes'] = { value = '"\'\'"', expectedOutput = "''" },
        ['escaped double quotes'] = { value = "'\"\"'", expectedOutput = '""' },
        ['escaped single quoted character'] = { value = '"\'a\'"', expectedOutput = "'a'" },
        ['escaped double quoted character'] = { value = "'\"a\"'", expectedOutput = '"a"' },
    })
    :register()

-- @covers Str:removeWrappers()
TestCase.new()
    :setName('removeWrappers')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:removeWrappers(data.value, data.wrapper, data.endWrapper))
    end)
    :setScenarios({
        ['<a>'] = { value = '<a>', wrapper = '<', endWrapper = '>', expectedOutput = 'a', },
        ['_(a)_'] = { value = '_(a)_', wrapper = '_(', endWrapper = ')_', expectedOutput = 'a', },
        ['""'] = { value = '""', wrapper = '"', endWrapper = nil, expectedOutput = '', },
        ['"a"'] = { value = '"a"', wrapper = '"', endWrapper = nil, expectedOutput = 'a', },
        ["'a'"] = { value = "'a'", wrapper = "'", endWrapper = nil, expectedOutput = 'a', },
        ["''"] = { value = "''", wrapper = "'", endWrapper = nil, expectedOutput = '', },
        ['"a'] = { value = '"a', wrapper = '"', endWrapper = nil, expectedOutput = '"a', },
        ['a'] = { value = 'a', wrapper = '', endWrapper = nil, expectedOutput = 'a', },
        ['e. case - a'] = { value = 'a', wrapper = 'a', endWrapper = nil, expectedOutput = 'a', },
        ['e. case - empty'] = { value = '', wrapper = '', endWrapper = '', expectedOutput = '', },
        ['e. case - nil'] = { value = nil, wrapper = '', endWrapper = '', expectedOutput = nil, },
        ['e. case - endWrapper empty'] = { value = '', wrapper = nil, endWrapper = '', expectedOutput = '', },
        ['e. case - all nil'] = { value = nil, wrapper = nil, endWrapper = nil, expectedOutput = nil, },
        ['won\'t remove internal wrappers'] = { value = '"a"b"c"', wrapper = '"', endWrapper = nil, expectedOutput = 'a"b"c', },
    })
    :register()

-- @covers Str:replaceAll()
TestCase.new()
    :setName('replaceAll')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:replaceAll(data.value, data.find, data.replace))
    end)
    :setScenarios({
        ['all empty'] = { value = '', find = '', replace = '', expectedOutput = '' },
        ['empty value'] = { value = '', find = 'a', replace = 'b', expectedOutput = '' },
        ['single character'] = { value = 'a', find = 'a', replace = 'b', expectedOutput = 'b' },
        ['multiple characters'] = { value = 'aabb', find = 'a', replace = 'b', expectedOutput = 'bbbb' },
        ['dot'] = { value = 'aa.bb', find = '.', replace = '_', expectedOutput = 'aa_bb' },
        ['opening ('] = { value = 'aa(bb)', find = '(', replace = '-', expectedOutput = 'aa-bb)' },
        ['closing )'] = { value = 'aa(bb)', find = ')', replace = '-', expectedOutput = 'aa(bb-' },
        ['word'] = { value = 'a word', find = 'word', replace = 'phrase', expectedOutput = 'a phrase' },
        ['word and dot'] = { value = 'this is a test.', find = 'test.', replace = 'result', expectedOutput = 'this is a result' },
        ['opening ['] = { value = 'test[with square brackets', find = '[', replace = ' ', expectedOutput = 'test with square brackets' },
        ['closing ]'] = { value = 'test]with square brackets', find = ']', replace = ' ', expectedOutput = 'test with square brackets' },
        ['backslash'] = { value = 'test\\with backslash', find = '\\', replace = ' ', expectedOutput = 'test with backslash' },
        ['double quotes'] = { value = 'test with "double quotes"', find = '"', replace = '', expectedOutput = 'test with double quotes' },
        ['single quotes'] = { value = "test with 'quotes'", find = "'", replace = '', expectedOutput = 'test with quotes' },
    })
    :register()

-- @covers Str:split()
TestCase.new()
    :setName('split')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:split(data.value, data.separator))
    end)
    :setScenarios({
        ['empty string'] = {
            value = '',
            separator = '.',
            expectedOutput = {},
        },
        ['single word'] = {
            value = 'test',
            separator = '.',
            expectedOutput = { 'test' },
        },
        ['multiple words'] = {
            value = 'test-a.test-b.test-c',
            separator = '.',
            expectedOutput = { 'test-a', 'test-b', 'test-c' },
        },
        ['multiple words with spaces'] = {
            value = 'test-a test-b test-c',
            separator = ' ',
            expectedOutput = { 'test-a', 'test-b', 'test-c' },
        },
    })
    :register()

-- @covers Str:startsWith()
TestCase.new()
    :setName('startsWith')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:startsWith(data.value, data.prefix))
    end)
    :setScenarios({
        ['empty string'] = {
            value = '',
            prefix = '',
            expectedOutput = false,
        },
        ['empty prefix'] = {
            value = 'a',
            prefix = '',
            expectedOutput = false,
        },
        ['single character'] = {
            value = 'a',
            prefix = 'a',
            expectedOutput = true,
        },
        ['single word'] = {
            value = 'word',
            prefix = 'word',
            expectedOutput = true,
        },
        ['case sensitive'] = {
            value = 'Hello, world!',
            prefix = 'hello',
            expectedOutput = false,
        },
        ['multiple words'] = {
            value = 'hello, world!',
            prefix = 'hello',
            expectedOutput = true,
        },
    })
    :register()

-- @covers Str:trim()
TestCase.new()
    :setName('trim')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:trim(data.value))
    end)
    :setScenarios({
        ['nil'] = { value = nil, expectedOutput = nil },
        ['empty string'] = { value = '', expectedOutput = '' },
        ['whitespace'] = { value = ' ', expectedOutput = '' },
        ['multiple whitespace'] = { value = '  ', expectedOutput = '' },
        ['lots of whitespaces'] = { value = '    ', expectedOutput = '' },
        ['single character'] = { value = 'a', expectedOutput = 'a' },
        ['starts with empty space'] = { value = ' a', expectedOutput = 'a' },
        ['ends with whitespace'] = { value = 'a ', expectedOutput = 'a' },
        ['wrapped by whitespaces'] = { value = ' a ', expectedOutput = 'a' },
        ['wrapped by multiple whitespaces'] = { value = '  a  ', expectedOutput = 'a' },
        ['wrapped by and with whitespaces'] = { value = '  a b  ', expectedOutput = 'a b' },
        ['whitespaces all over the place'] = { value = '  a  b  ', expectedOutput = 'a  b' },
    })
    :register()

-- @covers Str:ucFirst()
TestCase.new()
    :setName('ucFirst')
    :setTestClass(TestStr)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, __.str:ucFirst(data.value))
    end)
    :setScenarios({
        ['empty string'] = {
            value = '',
            expectedOutput = '',
        },
        ['single character'] = {
            value = 'a',
            expectedOutput = 'A',
        },
        ['single word'] = {
            value = 'word',
            expectedOutput = 'Word',
        },
        ['multiple words'] = {
            value = 'hello, world!',
            expectedOutput = 'Hello, world!',
        },
    })
    :register()
-- end of TestStr
