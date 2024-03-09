-- @see testStrCanSplit
local function testStrCanSplitExecution(value, separator, expectedOutput)
    lu.assertEquals(__.str:split(value, separator), expectedOutput)
end

--[[
@covers Str:split()
]]
function testStrCanSplit()
    testStrCanSplitExecution('', '.', {})
    testStrCanSplitExecution('test', '.', {'test'})
    testStrCanSplitExecution('test-a.test-b.test-c', '.', {'test-a', 'test-b', 'test-c'})
end