-- @see testArrCanGet
local function testArrCanGetExecution(list, key, default, expectedOutput)
    lu.assertEquals(__.arr:get(list, key, default), expectedOutput)
end

--[[
@covers Arr:get()
]]
function testArrCanGet()
    testArrCanGetExecution({}, 'test', nil, nil)
    testArrCanGetExecution({}, 'test', 'default', 'default')

    local listWithSingleObject = {}
    listWithSingleObject['test'] = 'test'
    testArrCanGetExecution(listWithSingleObject, 'test', nil, 'test')

    local listWithNestedKeys = {}
    listWithNestedKeys['test-a'] = {}
    listWithNestedKeys['test-a']['test-b'] = {}
    listWithNestedKeys['test-a']['test-b']['test-c'] = 'test'
    testArrCanGetExecution(listWithNestedKeys, 'test-a.test-b.test-c', nil, 'test')
end

--[[
@covers Arr
]]
function testArrCanGetInstance()
    local arr = __.arr

    lu.assertNotIsNil(arr)
end

--[[
@covers Arr:implode()
]]
function testArrCanImplode()
    local arr = __.arr

    local delimiter = ','
    local list = {'a', 'b', 'c'}

    local result = arr:implode(delimiter, list)

    lu.assertEquals(result, 'a,b,c')
end

--[[
@covers Arr:implode()
]]
function testArrCanImplodeWithNonList()
    local arr = __.arr

    local text = 'test'
    local result = arr:implode(',', text)

    lu.assertEquals(result, text)
end

-- @see testArrCanMap
local function testArrCanMapExecution(list, expectedOutput)
    local arr = __.arr

    local results = __.arr:map(list, function (val, i)
        return val .. '-' .. i
    end)

    lu.assertEquals(results, expectedOutput)
end

--[[
@covers Arr:map()
]]
function testArrCanMap()
    testArrCanMapExecution({}, {})
    testArrCanMapExecution({'test', 'test', 'test'}, {'test-1', 'test-2', 'test-3'})
    testArrCanMapExecution({['a'] = 'a', ['b'] = 'b', ['c'] = 'c'}, {['a'] = 'a-a', ['b'] = 'b-b', ['c'] = 'c-c'})
end

--[[
@covers Arr:set()
]]
function testArrCanSet()
    local arr = __.arr

    local list = {}
    list['a'] = {}
    list['a']['b'] = 'test-initial'

    -- sanity checks to make sure the list is consistent
    lu.assertEquals(arr:get(list, 'a.b'), 'test-initial')
    lu.assertIsNil(arr:get(list, 'a.c'))
    lu.assertIsNil(arr:get(list, 'x.y.z'))

    -- sets a couple of properties
    arr:set(list, 'a.c', 'test-with-set')
    arr:set(list, 'x.y.z', 'test-with-three-levels')

    -- checks if the property 
    lu.assertEquals(arr:get(list, 'a.c'), 'test-with-set')
    lu.assertEquals(arr:get(list, 'x.y.z'), 'test-with-three-levels')
    lu.assertEquals(arr:get(list, 'a.b'), 'test-initial')
end

-- @see testArrInArray
local function testArrInArrayExecution(list, value, expectedResult, expectedIndex)
    local result, index = __.arr:inArray(list, value)
    
    lu.assertEquals(result, expectedResult)
    lu.assertEquals(index, expectedIndex)
end

--[[
@covers Arr:inArray()
]]
function testArrInArray()
    testArrInArrayExecution({}, nil, false, 0)
    testArrInArrayExecution({'a', 'b', 'c'}, 'd', false, 0)
    testArrInArrayExecution({'a', 'b', 'c'}, 'a', true, 1)
    testArrInArrayExecution({'a', 'b', 'c'}, 'c', true, 3)
    testArrInArrayExecution({a = 'a', b = 'b', c = 'c'}, 'c', true, 'c')

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

    testArrInArrayExecution({objectA, objectB}, objectC, false, 0)
    testArrInArrayExecution({objectA, objectB}, objectB, true, 2)
end

--[[
@covers Arr:isArray()
]]
function testArrIsArray()
    local arr = __.arr

    lu.assertIsTrue(arr:isArray({'a', 'b', 'c'}))

    lu.assertIsFalse(arr:isArray(1))
    lu.assertIsFalse(arr:isArray('a'))
    lu.assertIsFalse(arr:isArray(arr))

    local tableWithStringKeys = {}
    arr:set(tableWithStringKeys, 'a.b.c', 'test')
    lu.assertIsFalse(arr:isArray(tableWithStringKeys))
end

-- @see testArrMaybeInitialize
local function testArrMaybeInitializeExecution(list, key, value, expectedValue)
    local arr = __.arr

    arr:maybeInitialize(list, key, value)

    lu.assertEquals(arr:get(list, key), expectedValue)
end

--[[
@covers Arr:maybeInitialize()
]]
function testArrMaybeInitialize()
    local list = {}

    testArrMaybeInitializeExecution(list, 'test-key', 'test-value', 'test-value')
    testArrMaybeInitializeExecution(list, 'test-key', 'test-value-again', 'test-value')
end