TestConfiguration = BaseTestClass:new()
    -- @covers Configuration:__construct()
    function TestConfiguration:testConstruct()
        local savedVariable = {['test-property'] = 'test-value'}

        local instance = __:new('Configuration', savedVariable)

        lu.assertNotNil(instance)
        lu.assertEquals(savedVariable, instance.data)
    end

    -- @covers StormwindLibrary:config()
    function TestConfiguration:testConfig()
        local arg1, arg2 = nil, nil

        __.isConfigEnabled = function() return false end

        lu.assertIsNil(__:config('test-property', 'default-value'))

        __.configuration = __:new('Configuration', {})

        function __.configuration:handle(...) arg1, arg2 = ... end

        __.isConfigEnabled = function() return true end

        __:config('test-property', 'default-value')

        lu.assertEquals('test-property', arg1)
        lu.assertEquals('default-value', arg2)
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

        lu.assertEquals('test-get-result', result)
        lu.assertEquals(data, listArg)
        lu.assertEquals('test-key', keyArg)
        lu.assertEquals('test-default', defaultValueArg)
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

        lu.assertEquals('test-get-result', result)
        lu.assertEquals(data, miListArg)
        lu.assertEquals('test-key', miKeyArg)
        lu.assertEquals('test-default', miInitialValueArg)
        lu.assertEquals('test-key', getKeyArg)
        lu.assertEquals('test-default', getDefaultValueArg)
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

            lu.assertEquals(shouldCallGetOrInitialize and arg1 or nil, keyArg)
            lu.assertEquals(shouldCallGetOrInitialize and arg2 or nil, defaultValueArg)
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

            lu.assertEquals(arg1, keyArg)
            lu.assertEquals(arg2, defaultValueArg)
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

        local expectedKeyArgs = {'test-key-a', 'test-key-b', 'test-key-c'}
        local expectedValueArgs = {'test-value-a', 'test-value-b', 'test-value-c'}

        for i, key in ipairs(keyArgs) do lu.assertTableContains(expectedKeyArgs, key) end
        for i, value in ipairs(valueArgs) do lu.assertTableContains(expectedValueArgs, value) end
    end

    -- @covers Configuration:handle()
    function TestConfiguration:testHandleWithNoData()
        local configuration = __:new('Configuration')

        lu.assertEquals(nil, configuration:handle())

        lu.assertIsTrue(__.output:printed('There was an attempt to get or set configuration values with no addon respective data set. Please, pass the data variable name when initializing the Stormwind Library to use this feature.'))
    end

    -- @covers Configuration:handle()
    -- Tests the handle method with data close to a real scenario
    function TestConfiguration:testHandleWithRealData()
        local data = {
            rate = 0.1,
            ['z-index'] = 100,
            settings = {
                ['show-tooltip'] = true,
                ['show-confirmation'] = false,
            },
        }

        local configuration = __:new('Configuration', data)

        lu.assertEquals(0.1, configuration:handle('rate'))
        lu.assertEquals(0.1, configuration:handle('rate', 0.2))
        lu.assertEquals(100, configuration:handle('z-index'))
        lu.assertEquals(1.0, configuration:handle('opacity', 1.0))
        lu.assertEquals(true, configuration:handle('settings.show-tooltip'))

        configuration:handle({
            ['rate'] = 0.2,
            ['z-index'] = 200,
            ['settings.show-tooltip'] = false,
        })

        lu.assertEquals(0.2, configuration:handle('rate'))
        lu.assertEquals(200, configuration:handle('z-index'))

        lu.assertEquals(false, configuration:handle('settings.show-tooltip'))

        lu.assertIsNil(__.arr:get(data, 'settings.view-mode'))

        -- tries to get a non-existent key, but that should be initialized
        configuration:handle('settings.view-mode', 'compact', true)

        lu.assertEquals('compact', configuration:handle('settings.view-mode'))

        -- any invalid call should return nil
        lu.assertIsNil(configuration:handle(1))
    end

    -- @covers StormwindLibrary:isConfigEnabled()
    function TestConfiguration:testIsConfigEnabled()
        local function execution(instance, expectedOutput)
            -- @TODO: Remove this method once the library offers a structure
            --        to execute callbacks when it's loaded <2024.04.22>
            __.maybeInitializeConfiguration = function() end
            __.configuration = instance

            lu.assertEquals(expectedOutput, __:isConfigEnabled())
        end

        execution(nil, false)
        execution({}, true)
    end

    -- @covers StormwindLibrary:maybeInitializeConfiguration()
    function TestConfiguration:testMaybeInitializeConfiguration()
        local function execution(addonDataPropertyName, configuration, globalDataTable, expectedConfiguration)
            __.configuration = configuration
            __.addon.data = addonDataPropertyName
            if globalDataTable then _G[addonDataPropertyName] = globalDataTable end

            __:maybeInitializeConfiguration()

            lu.assertEquals(expectedConfiguration, __.configuration)
        end

        execution(nil, nil, nil, nil)
        execution('test-data', nil, nil, __:new('Configuration', {}))

        local addonData = {['test-key'] = 'test-value'}
        execution('test-data', nil, addonData, __:new('Configuration', addonData))

        local configuration = __:new('Configuration', {'test-configuration'})
        execution('test-data', configuration, nil, configuration)
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

        lu.assertEquals(data, setListArg)
        lu.assertEquals('test-key', setKeyArg)
        lu.assertEquals('test-value', setValueArg)
    end

    -- @covers Configuration:setPrefixKey()
    function TestConfiguration:testSetPrefixKey()
        local instance = __:new('Configuration', {})

        lu.assertIsNil(instance.prefixKey)

        instance:setPrefixKey('test-prefix')

        lu.assertEquals('test-prefix', instance.prefixKey)
    end
-- end of TestConfiguration