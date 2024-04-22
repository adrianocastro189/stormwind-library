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
    function TestConfiguration:testHandleToGetOrInitializeValues()
        local function execution(arg1, arg2, arg3, shouldCallGetOrInitialize)
            local keyArg, defaultValueArg = nil, nil

            local configuration = __:new('Configuration', {})

            function configuration:getOrInitialize(key, defaultValue)
                keyArg = key
                defaultValueArg = defaultValue
            end

            configuration:handle(arg1, arg2, arg3)

            lu.assertEquals(keyArg, shouldCallGetOrInitialize and arg1 or nil)
            lu.assertEquals(defaultValueArg, shouldCallGetOrInitialize and arg2 or nil)
        end

        execution('test', nil, nil, false)
        execution('test', 'default', nil, false)
        execution('test', 'default', false, false)
        execution('test', 'default', 'no', false)
        execution('test', 'default', true, true)
        execution('test', 'default', 'yes', true)
    end

    -- @covers Configuration:handle()
    function TestConfiguration:testHandleToGetValues()
        local function execution(arg1, arg2)
            local keyArg, defaultValueArg = nil, nil

            local configuration = __:new('Configuration', {})

            function configuration:get(key, defaultValue)
                keyArg = key
                defaultValueArg = defaultValue
            end

            configuration:handle(arg1, arg2)

            lu.assertEquals(keyArg, arg1)
            lu.assertEquals(defaultValueArg, arg2)
        end

        execution('test', nil)
        execution('test', 'default-value')
    end

    -- @covers Configuration:handle()
    function TestConfiguration:testHandleToSet()
        local configuration = __:new('Configuration', {})

        local keyArgs, valueArgs = {}, {}

        function configuration:set(key, value)
            table.insert(keyArgs, key)
            table.insert(valueArgs, value)
        end

        configuration:handle({
            ['test-key-a'] = 'test-value-a',
            ['test-key-b'] = 'test-value-b',
            ['test-key-c'] = 'test-value-c',
        })

        lu.assertEquals(keyArgs, {'test-key-a', 'test-key-b', 'test-key-c'})
        lu.assertEquals(valueArgs, {'test-value-a', 'test-value-b', 'test-value-c'})
    end

    -- @covers Configuration:handle()
    function TestConfiguration:testHandleWithNoData()
        local configuration = __:new('Configuration')

        lu.assertEquals(nil, configuration:handle())

        lu.assertIsTrue(__.output:printed('There was an attempt to get or set configuration values with no addon respective data set. Please, pass the data variable name when initializing the Stormwind Library to use this feature.'))
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
        local setListArg, setKeyArg, setValueArg = nil, nil, nil

        function __.arr:set(list, key, value)
            setListArg, setKeyArg, setValueArg = list, key, value
        end

        local data = {'test-data'}

        local instance = __:new('Configuration', data)

        instance:set('test-key', 'test-value')

        lu.assertEquals(setListArg, data)
        lu.assertEquals(setKeyArg, 'test-key')
        lu.assertEquals(setValueArg, 'test-value')
    end
-- end of TestConfiguration