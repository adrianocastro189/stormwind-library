TestArr = {}
    -- @covers Arr:get()
    function TestArr:testCanGet()
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
    end

    -- @covers Arr
    function TestArr:testCanGetInstance()
        local arr = __.arr

        lu.assertNotIsNil(arr)
    end

    -- @covers Arr:implode()
    function TestArr:testCanImplode()
        local arr = __.arr

        local delimiter = ','
        local list = {'a', 'b', 'c'}

        local result = arr:implode(delimiter, list)

        lu.assertEquals('a,b,c', result)
    end

    -- @covers Arr:implode()
    function TestArr:testCanImplodeWithNonList()
        local arr = __.arr

        local text = 'test'
        local result = arr:implode(',', text)

        lu.assertEquals(text, result)
    end

    -- @covers Arr:insertNotInArray()
    function TestArr:testCanInsertNotInArray()
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

    -- @covers Arr:map()
    function TestArr:testCanMap()
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

    -- @covers Arr:set()
    function TestArr:testCanSet()
        local arr = __.arr

        local list = {}
        list['a'] = {}
        list['a']['b'] = 'test-initial'

        -- sanity checks to make sure the list is consistent
        lu.assertEquals('test-initial', arr:get(list, 'a.b'))
        lu.assertIsNil(arr:get(list, 'a.c'))
        lu.assertIsNil(arr:get(list, 'x.y.z'))

        -- sets a couple of properties
        arr:set(list, 'a.c', 'test-with-set')
        arr:set(list, 'x.y.z', 'test-with-three-levels')

        -- checks if the property 
        lu.assertEquals('test-with-set', arr:get(list, 'a.c'))
        lu.assertEquals('test-with-three-levels', arr:get(list, 'x.y.z'))
        lu.assertEquals('test-initial', arr:get(list, 'a.b'))
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

    -- @covers Arr:maybeInitialize()
    function TestArr:testMaybeInitialize()
        local function execution(list, key, value, expectedValue)
            local arr = __.arr
    
            arr:maybeInitialize(list, key, value)
    
            lu.assertEquals(expectedValue, arr:get(list, key))
        end

        local list = {}

        execution(list, 'test-key', 'test-value', 'test-value')
        execution(list, 'test-key', 'test-value-again', 'test-value')
    end

    -- @covers Arr:pluck()
    function TestArr:testPluck()
        local function execution(list, key, expectedOutput)
            local output = __.arr:pluck(list, key)
    
            lu.assertEquals(expectedOutput, output)
        end

        execution({}, 'test-key', {})

        local objectA = {['test-key'] = {['test-nested-key'] = 'test-value'}}
        local objectB = {['test-key'] = nil}
        local objectC = {}

        execution({objectA, objectB, objectC}, 'test-key.test-nested-key', {'test-value'})
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
-- end of TestArr