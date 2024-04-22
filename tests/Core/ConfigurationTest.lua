TestConfiguration = BaseTestClass:new()
    -- @covers Configuration:__construct()
    function TestConfiguration:testConstruct()
        local savedVariable = {['test-property'] = 'test-value'}

        local instance = __:new('Configuration', savedVariable)

        lu.assertNotNil(instance)
        lu.assertEquals(instance.data, savedVariable)
    end

    -- @covers StormwindLibrary:config()
    function TestConfiguration:testConfig()
        local arg1, arg2 = nil, nil

        function __.configuration:handle(...) arg1, arg2 = ... end

        __:config('test-property', 'default-value')

        lu.assertEquals(arg1, 'test-property')
        lu.assertEquals(arg2, 'default-value')
    end

    -- @covers Configuration:get()
    function TestConfiguration:testGet()
        local listArg, keyArg, defaultValueArg = nil, nil, nil

        function __.arr:get(list, key, default)
            listArg, keyArg, defaultValueArg = list, key, default
            return 'test-get-result'
        end

        local data = {'test-data'}

        local result = __:new('Configuration', data):get('test-key', 'test-default')

        lu.assertEquals(result, 'test-get-result')
        lu.assertEquals(listArg, data)
        lu.assertEquals(keyArg, 'test-key')
        lu.assertEquals(defaultValueArg, 'test-default')
    end

    -- @covers Configuration:getOrInitialize()
    function TestConfiguration:testGetOrInitialize()
        -- in this context, mi stands to "maybe initialize"
        local miListArg, miKeyArg, miInitialValueArg = nil, nil, nil
        local getKeyArg, getDefaultValueArg = nil, nil

        function __.arr:maybeInitialize(list, key, initialValue)
            miListArg, miKeyArg, miInitialValueArg = list, key, initialValue
        end

        local data = {'test-data'}

        local instance = __:new('Configuration', data)

        function instance:get(key, defaultValue)
            getKeyArg, getDefaultValueArg = key, defaultValue

            return 'test-get-result'
        end

        local result = instance:getOrInitialize('test-key', 'test-default')

        lu.assertEquals(result, 'test-get-result')
        lu.assertEquals(miListArg, data)
        lu.assertEquals(miKeyArg, 'test-key')
        lu.assertEquals(miInitialValueArg, 'test-default')
        lu.assertEquals(getKeyArg, 'test-key')
        lu.assertEquals(getDefaultValueArg, 'test-default')
    end

    -- @covers Configuration:handle()
    function TestConfiguration:testHandle()
        -- @TODO: Implement this test <2024.04.22>
    end

    -- @covers StormwindLibrary:isConfigEnabled()
    function TestConfiguration:testIsConfigEnabled()
        local function execution(instance, expectedOutput)
            __.configuration = instance

            lu.assertEquals(expectedOutput, __:isConfigEnabled())
        end

        execution(nil, false)
        execution({}, true)
    end

    -- @covers StormwindLibrary.configuration
    function TestConfiguration:testLibraryInstanceIsSet()
        lu.assertNotIsNil(__.configuration)
    end

    -- @covers Configuration:set()
    function TestConfiguration:testSet()
        -- @TODO: Implement this test <2024.04.22>
    end
-- end of TestConfiguration