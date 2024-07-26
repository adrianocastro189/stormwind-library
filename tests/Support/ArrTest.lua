TestArr = BaseTestClass:new()
    -- @covers Arr:any()
    function TestArr:testAny()
        local execution = function(list, callback, expectedOutput)
            lu.assertEquals(expectedOutput, __.arr:any(list, callback))
        end

        execution(nil, function () return true end, false)
        execution({}, function () return true end, false)
        execution({'a', 'b', 'c'}, function (val) return val == 'd' end, false)
        execution({'a', 'b', 'c'}, function (val) return val == 'b' end, true)
    end

    -- @covers Arr
    function TestArr:testArrInstanceIsSet()
        local arr = __.arr

        lu.assertNotIsNil(arr)
    end

    -- @covers Arr:concat()
    function TestArr:testConcat()
        local function execution(lists, expectedOutput)
            local results = __.arr:concat(__.arr:unpack(lists))
    
            lu.assertEquals(expectedOutput, results)
        end

        -- called with empty tables
        execution({{}, {}}, {})

        -- called with string arrays
        execution({{'a'}, {'b'}}, {'a', 'b'})

        -- called with string arrays and repeated values
        execution({{'a', 'b'}, {'b', 'c'}}, {'a', 'b', 'b', 'c'})

        -- called with tables
        execution({{a = 'a'}, {b = 'b'}}, {'a', 'b'})

        -- called with tables and repeated keys
        execution({{a = 'a'}, {b = 'b'}, {c = 'c'}}, {'a', 'b', 'c'})
    end

    -- @covers Arr:count()
    function TestArr:testCount()
        local function execution(list, expectedOutput)
            lu.assertEquals(expectedOutput, __.arr:count(list))
        end

        execution({}, 0)
        execution({3, 4, 5}, 3)
        execution({'a', 'b', 'c'}, 3)
        execution({a = 'a', b = 'b', c = 'c'}, 3)
    end

    -- @covers Arr:each()
    function TestArr:testEach()
        local function execution(list, expectedOutput)
            local results = {}
            __.arr:each(list, function (val, i)
                table.insert(results, val .. '-' .. i)
            end)
    
            -- can't use lu.assertEquals because the order of the elements is not
            -- guaranteed by the each function
            for i, v in ipairs(expectedOutput) do
                lu.assertTableContains(results, v)
            end
        end

        execution({}, {})
        execution({'test', 'test', 'test'}, {'test-1', 'test-2', 'test-3'})
        execution({['a'] = 'a', ['b'] = 'b', ['c'] = 'c'}, {'a-a', 'b-b', 'c-c'})
    end

    -- @covers Arr:freeze()
    function TestArr:testFreeze()
        local arr = __.arr

        local table = {TEST_CONSTANT = 'a'}

        -- makes sure this table can be modified
        table['TEST_CONSTANT'] = 'b'

        local constants = arr:freeze(table)

        lu.assertErrorMsgContains("TEST_CONSTANT is a constant and can't be changed", function()
            constants['TEST_CONSTANT'] = 'c'
        end)
        lu.assertEquals('b', constants['TEST_CONSTANT'])
    end

    -- @covers Arr:get()
    function TestArr:testGet()
        local function execution(list, key, default, expectedOutput)
            lu.assertEquals(expectedOutput, __.arr:get(list, key, default))
        end

        execution({}, 'test', nil, nil)
        execution({}, 'test', 'default', 'default')

        local listWithSingleObject = {}
        listWithSingleObject['test'] = 'test'
        execution(listWithSingleObject, 'test', nil, 'test')

        local listWithNestedKeys = {}
        listWithNestedKeys['test-a'] = {}
        listWithNestedKeys['test-a']['test-b'] = {}
        listWithNestedKeys['test-a']['test-b']['test-c'] = 'test'
        execution(listWithNestedKeys, 'test-a.test-b.test-c', nil, 'test')

        local listWithNestedIndexedTable = {}
        listWithNestedIndexedTable['test-a'] = {'a', 'b', 'c'}
        execution(listWithNestedIndexedTable, 'test-a.2', nil, 'b')

        local listWithFalseValue = {}
        listWithFalseValue['test'] = false
        execution(listWithFalseValue, 'test', nil, false)
    end

    -- @covers Arr:hasKey()
    function TestArr:testHasKey()
        local function execution(list, key, expectedOutput)
            lu.assertEquals(expectedOutput, __.arr:hasKey(list, key))
        end

        -- with empty list
        execution({}, 'test', false)

        -- list with keys
        execution({a = 'a', b = 'b', c = 'c'}, 'a', true)
        execution({a = 'a', b = 'b', c = 'c'}, 'd', false)

        -- with nested keys
        local listWithNestedKeys = {}
        listWithNestedKeys['test-a'] = {}
        listWithNestedKeys['test-a']['test-b'] = {}
        execution(listWithNestedKeys, 'test-a', true)
        execution(listWithNestedKeys, 'test-a.test-b', true)
        execution(listWithNestedKeys, 'test-a.test-b.test-c', false)

        -- with indexed list
        execution({'a', 'b', 'c'}, 1, true)
    end

    -- @covers Arr:implode()
    function TestArr:testImplode()
        local arr = __.arr

        local delimiter = ','
        local list = {'a', 'b', 'c'}

        local result = arr:implode(delimiter, list)

        lu.assertEquals('a,b,c', result)
    end

    -- @covers Arr:implode()
    function TestArr:testImplodeWithNonList()
        local arr = __.arr

        local text = 'test'
        local result = arr:implode(',', text)

        lu.assertEquals(text, result)
    end

    -- @covers Arr:inArray()
    function TestArr:testInArray()
        local function execution(list, value, expectedResult, expectedIndex)
            local result, index = __.arr:inArray(list, value)
            
            lu.assertEquals(expectedResult, result)
            lu.assertEquals(expectedIndex, index)
        end

        execution({}, nil, false, 0)
        execution({'a', 'b', 'c'}, 'd', false, 0)
        execution({'a', 'b', 'c'}, 'a', true, 1)
        execution({'a', 'b', 'c'}, 'c', true, 3)
        execution({a = 'a', b = 'b', c = 'c'}, 'c', true, 'c')

        local ComparableObject = {}
        ComparableObject.__index = ComparableObject
        ComparableObject.__ = self
        function ComparableObject:new(value)
            local self = setmetatable({}, ComparableObject)
            self.value = value
            return self
        end
        function ComparableObject:__eq(object) return self.value == object.value end

        local objectA = ComparableObject:new('test-object-a')
        local objectB = ComparableObject:new('test-object-b')
        local objectC = ComparableObject:new('test-object-c')

        execution({objectA, objectB}, objectC, false, 0)
        execution({objectA, objectB}, objectB, true, 2)
    end

    -- @covers Arr:insertNotInArray()
    function TestArr:testInsertNotInArray()
        local function execution(list, value, expectedBooleanResult, expectedListResult)
            local booleanResult = __.arr:insertNotInArray(list, value)
    
            lu.assertEquals(expectedBooleanResult, booleanResult)
            lu.assertEquals(expectedListResult, list)
        end

        execution('a', 'a', false, 'a')
        execution({}, 'a', true, {'a'})
        execution({'a'}, 'a', false, {'a'})
        execution({'a'}, 'b', true, {'a', 'b'})
    end

    -- @covers Arr:isArray()
    function TestArr:testIsArray()
        local arr = __.arr

        lu.assertIsTrue(arr:isArray({'a', 'b', 'c'}))

        lu.assertIsFalse(arr:isArray(1))
        lu.assertIsFalse(arr:isArray('a'))
        lu.assertIsFalse(arr:isArray(arr))

        local tableWithStringKeys = {}
        arr:set(tableWithStringKeys, 'a.b.c', 'test')
        lu.assertIsFalse(arr:isArray(tableWithStringKeys))
    end

    -- @covers Arr:map()
    function TestArr:testMap()
        local function execution(list, expectedOutput)
            local arr = __.arr
    
            local results = __.arr:map(list, function (val, i)
                return val .. '-' .. i
            end)
    
            lu.assertEquals(expectedOutput, results)
        end

        execution({}, {})
        execution({'test', 'test', 'test'}, {'test-1', 'test-2', 'test-3'})
        execution({['a'] = 'a', ['b'] = 'b', ['c'] = 'c'}, {['a'] = 'a-a', ['b'] = 'b-b', ['c'] = 'c-c'})
    end

    -- @covers Arr:maybeInitialize()
    function TestArr:testMaybeInitialize()
        local function execution(list, key, value, expectedValue)
            local arr = __.arr
    
            arr:maybeInitialize(list, key, value)
    
            lu.assertEquals(expectedValue, arr:get(list, key))
        end

        local list = {}

        execution(list, 'test-key.test-inner-key', 'test-value', 'test-value')
        execution(list, 'test-key.test-inner-key', 'test-value-again', 'test-value')
    end

    -- @covers Arr:pluck()
    function TestArr:testPluck()
        local function execution(list, key, expectedOutput)
            local output = __.arr:pluck(list, key)
    
            lu.assertEquals(expectedOutput, output)
        end

        execution({}, 'test-key', {})

        local objectA = {['test-key'] = {['test-nested-key'] = {'test-value-1', 'test-value-2'}}}
        local objectB = {['test-key'] = nil}
        local objectC = {}

        execution({objectA, objectB, objectC}, 'test-key.test-nested-key.2', {'test-value-2'})
    end

    -- @covers Arr:remove()
    function TestArr:testRemove()
        local execution = function(list, key, expectedOutput)
            local arr = __.arr
            arr:remove(list, key)
            lu.assertEquals(expectedOutput, list)
        end

        execution({}, 'test', {})
        execution({'test'}, 'test', {})
        execution({'a', 'b', 'c'}, 'a', {'b', 'c'})
        execution({1, 2, 3}, 2, {1, 3})
        execution({a = 'a', b = 'b', c = 'c'}, 'a', {a = 'a', b = 'b', c = 'c'})
    end

    -- @covers Arr:safeGet()
    function TestArr:testSafeGet()
        local function execution(list, key, expectedOutput)
            lu.assertEquals(expectedOutput, __.arr:safeGet(list, key))
        end

        -- with a nil list
        execution(nil, 'test', nil)

        -- with an empty list
        execution({}, 'test', nil)

        -- with an indexed list and string key
        execution({'a', 'b', 'c'}, '2', 'b')

        -- with an indexed list and number key
        execution({'a', 'b', 'c'}, 1, 'a')

        -- with an indexed list and non-existing key
        execution({'a', 'b', 'c'}, 4, nil)

        -- with non-indexed list and string key
        execution({a = 'a', b = 'b', c = 'c'}, 'a', 'a')

        -- with non-indexed list and non-existing key
        execution({a = 'a', b = 'b', c = 'c'}, 'd', nil)
    end

    -- @covers Arr:set()
    function TestArr:testSet()
        local arr = __.arr

        local list = {}
        list['a'] = {}
        list['a']['b'] = 'test-initial'

        -- sanity checks to make sure the list is consistent
        lu.assertEquals('test-initial', arr:get(list, 'a.b'))
        lu.assertIsNil(arr:get(list, 'a.c'))
        lu.assertIsNil(arr:get(list, 'x.y.z'))
        lu.assertIsNil(arr:get(list, 'f'))

        -- sets a couple of properties
        arr:set(list, 'a.c', 'test-with-set')
        arr:set(list, 'x.y.z', 'test-with-three-levels')
        arr:set(list, 'f', false)

        -- checks if the property 
        lu.assertEquals('test-with-set', arr:get(list, 'a.c'))
        lu.assertEquals('test-with-three-levels', arr:get(list, 'x.y.z'))
        lu.assertEquals('test-initial', arr:get(list, 'a.b'))
        lu.assertEquals(false, arr:get(list, 'f'))
    end

    -- @covers Arr:wrap()
    function TestArr:testWrap()
        local function execution(value, expectedOutput)
            lu.assertEquals(expectedOutput, __.arr:wrap(value))
        end

        execution(nil, {})
        execution({}, {})
        execution('test', {'test'})
        execution({'test'}, {'test'})
    end
-- end of TestArr