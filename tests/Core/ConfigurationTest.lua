TestConfiguration = BaseTestClass:new()

-- @covers Configuration:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        local savedVariable = { ['test-property'] = 'test-value' }

        local instance = __:new('Configuration', savedVariable)

        lu.assertNotNil(instance)
        lu.assertEquals(savedVariable, instance.data)
    end)
    :register()

-- @covers StormwindLibrary:config()
TestCase.new()
    :setName('config')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        local arg1, arg2 = nil, nil

        __ = Spy
            .new(__)
            :mockMethod('isConfigEnabled', function() return false end)

        lu.assertIsNil(__:config('test-property', 'default-value'))

        __.configuration = __:new('Configuration', {})

        function __.configuration:handle(...) arg1, arg2 = ... end

        __:mockMethod('isConfigEnabled', function() return true end)

        __:config('test-property', 'default-value')

        lu.assertEquals('test-property', arg1)
        lu.assertEquals('default-value', arg2)
    end)
    :register()

-- @covers Configuration:get()
TestCase.new()
    :setName('get')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        __.arr = Spy
            .new(__.arr)
            :mockMethod('get', function() return 'test-get-result' end)

        local data = { 'test-data' }

        local configuration = __:new('Configuration', data)

        -- this will confirm get is calling the maybePrefixKey() method
        configuration.prefixKey = 'test-prefix'

        local result = configuration:get('test-key', 'test-default')

        lu.assertEquals('test-get-result', result)

        __.arr
            :getMethod('get')
            :assertCalledOnceWith(data, 'test-prefix.test-key', 'test-default')
    end)
    :register()

-- @covers Configuration:getOrInitialize()
TestCase.new()
    :setName('getOrInitialize')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        __.arr = Spy
            .new(__.arr)
            :mockMethod('maybeInitialize')

        local data = { 'test-data' }

        local instance = Spy
            .new(__:new('Configuration', data))
            :mockMethod('get', function() return 'test-get-result' end)

        -- this will confirm getOrInitialize is calling the maybePrefixKey()
        -- method for the Arr:maybeInitialize() only
        instance.prefixKey = 'test-prefix'

        local result = instance:getOrInitialize('test-key', 'test-default')

        lu.assertEquals('test-get-result', result)

        __.arr
            :getMethod('maybeInitialize')
            :assertCalledOnceWith(data, 'test-prefix.test-key', 'test-default')

        instance
            :getMethod('get')
            :assertCalledOnceWith('test-key', 'test-default')
    end)
    :register()

-- @covers Configuration:handle()
TestCase.new()
    :setName('handle')
    :setTestClass(TestConfiguration)
    :setExecution(function(data)
        local keyArg, defaultValueArg = nil, nil

        local configuration = __:new('Configuration', {})

        function configuration:getOrInitialize(key, defaultValue)
            keyArg = key
            defaultValueArg = defaultValue
        end

        configuration:handle(data.arg1, data.arg2, data.arg3)

        lu.assertEquals(data.shouldCallGetOrInitialize and data.arg1 or nil, keyArg)
        lu.assertEquals(data.shouldCallGetOrInitialize and data.arg2 or nil, defaultValueArg)
    end)
    :setScenarios({
        ['single argument'] = {
            arg1 = 'test',
            arg2 = nil,
            arg3 = nil,
            shouldCallGetOrInitialize = false,
        },
        ['two arguments'] = {
            arg1 = 'test',
            arg2 = 'default',
            arg3 = nil,
            shouldCallGetOrInitialize = false,
        },
        ['three arguments with false'] = {
            arg1 = 'test',
            arg2 = 'default',
            arg3 = false,
            shouldCallGetOrInitialize = false,
        },
        ['three arguments with no'] = {
            arg1 = 'test',
            arg2 = 'default',
            arg3 = 'no',
            shouldCallGetOrInitialize = false,
        },
        ['three arguments with true'] = {
            arg1 = 'test',
            arg2 = 'default',
            arg3 = true,
            shouldCallGetOrInitialize = true,
        },
        ['three arguments with yes'] = {
            arg1 = 'test',
            arg2 = 'default',
            arg3 = 'yes',
            shouldCallGetOrInitialize = true,
        },
    })
    :register()

-- @covers Configuration:handle()
TestCase.new()
    :setName('handle to get values')
    :setTestClass(TestConfiguration)
    :setExecution(function(data)
        local configuration = Spy
            .new(__:new('Configuration', {}))
            :mockMethod('get')

        configuration:handle(data.arg1, data.arg2)

        configuration
            :getMethod('get')
            :assertCalledOnceWith(data.arg1, data.arg2)
    end)
    :setScenarios({
        ['nil default value'] = {
            arg1 = 'test',
            arg2 = nil,
        },
        ['default value'] = {
            arg1 = 'test',
            arg2 = 'default-value',
        },
    })
    :register()

-- @covers Configuration:handle()
TestCase.new()
    :setName('handle to set values')
    :setTestClass(TestConfiguration)
    :setExecution(function()
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

        local expectedKeyArgs = { 'test-key-a', 'test-key-b', 'test-key-c' }
        local expectedValueArgs = { 'test-value-a', 'test-value-b', 'test-value-c' }

        for i, key in ipairs(keyArgs) do lu.assertTableContains(expectedKeyArgs, key) end
        for i, value in ipairs(valueArgs) do lu.assertTableContains(expectedValueArgs, value) end
    end)
    :register()

-- @covers Configuration:handle()
TestCase.new()
    :setName('handle with no data')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        local configuration = __:new('Configuration')

        lu.assertEquals(nil, configuration:handle())

        lu.assertIsTrue(__.output:printed(
            'There was an attempt to get or set configuration values with no addon respective data set. Please, pass the data variable name when initializing the Stormwind Library to use this feature.'
        ))
    end)
    :register()

-- @covers Configuration:handle()
-- Tests the handle method with data close to a real scenario
TestCase.new()
    :setName('handle with real data')
    :setTestClass(TestConfiguration)
    :setExecution(function()
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
    end)
    :register()

-- @covers StormwindLibrary:isConfigEnabled()
TestCase.new()
    :setName('isConfigEnabled')
    :setTestClass(TestConfiguration)
    :setExecution(function(data)
        __.maybeInitializeConfiguration = function() end
        __.configuration = data.instance

        lu.assertEquals(data.expectedOutput, __:isConfigEnabled())
    end)
    :setScenarios({
        ['nil configuration'] = {
            instance = nil,
            expectedOutput = false,
        },
        ['empty configuration'] = {
            instance = {},
            expectedOutput = true,
        },
    })
    :register()

-- @covers StormwindLibrary:maybeInitializeConfiguration()
TestCase.new()
    :setName('maybeInitializeConfiguration')
    :setTestClass(TestConfiguration)
    :setExecution(function(data)
        _G['test-data'] = {}

        __.configuration = data.configuration
        __.playerConfiguration = data.playerConfiguration
        __.addon.data = data.addonDataPropertyName
        if data.globalDataTable then _G[data.addonDataPropertyName] = data.globalDataTable end

        __:maybeInitializeConfiguration()

        lu.assertEquals(data.expectedConfiguration, __.configuration)
        lu.assertEquals(data.expectedPlayerConfiguration, __.playerConfiguration)
    end)
    :setScenarios({
        ['no property name'] = {
            addonDataPropertyName = nil,
            configuration = nil,
            playerConfiguration = nil,
            globalDataTable = nil,
            expectedConfiguration = nil,
            expectedPlayerConfiguration = nil,
        },
        ['no global data table'] = function()
            return {
                addonDataPropertyName = 'test-data',
                configuration = nil,
                playerConfiguration = nil,
                globalDataTable = nil,
                expectedConfiguration = __:new('Configuration', {}),
                expectedPlayerConfiguration = __
                    :new('Configuration', {})
                    :setPrefixKey('test-realm.test-player-name'),
            }
        end,
        ['with global data table'] = function()
            return {
                addonDataPropertyName = 'test-data',
                configuration = nil,
                playerConfiguration = nil,
                globalDataTable = { ['test-key'] = 'test-value' },
                expectedConfiguration = __:new('Configuration', { ['test-key'] = 'test-value' }),
                expectedPlayerConfiguration = __
                    :new('Configuration', { ['test-key'] = 'test-value' })
                    :setPrefixKey('test-realm.test-player-name'),
            }
        end,
        ['player configuration'] = function()
            return {
                addonDataPropertyName = 'test-data',
                configuration = __:new('Configuration', { 'test-configuration' }),
                playerConfiguration = __
                    :new('Configuration', { 'test-configuration' })
                    :setPrefixKey('test-realm.test-player-name'),
                globalDataTable = nil,
                expectedConfiguration = __:new('Configuration', { 'test-configuration' }),
                expectedPlayerConfiguration = __
                    :new('Configuration', { 'test-configuration' })
                    :setPrefixKey('test-realm.test-player-name'),
            }
        end,
    })
    :register()

-- @covers Configuration:maybePrefixKey()
TestCase.new()
    :setName('maybePrefixKey')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        local instance = __:new('Configuration', {})

        lu.assertEquals('test-key', instance:maybePrefixKey('test-key'))

        instance:setPrefixKey('test-prefix')

        lu.assertEquals('test-prefix.test-key', instance:maybePrefixKey('test-key'))
    end)
    :register()

-- @covers StormwindLibrary:playerConfig()
TestCase.new()
    :setName('playerConfig')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        __ = Spy
            .new(__)
            :mockMethod('isConfigEnabled', function() return false end)

        lu.assertIsNil(__:playerConfig('test-property', 'default-value'))

        __.playerConfiguration = Spy
            .new(__:new('Configuration', {}))
            :mockMethod('handle')

        __:mockMethod('isConfigEnabled', function() return true end)

        __:playerConfig('test-property', 'default-value')

        __.playerConfiguration
            :getMethod('handle')
            :assertCalledOnceWith('test-property', 'default-value')
    end)
    :register()

-- @covers Configuration:set()
TestCase.new()
    :setName('set')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        __.arr = Spy
            .new(__.arr)
            :mockMethod('set')

        local data = { 'test-data' }

        local instance = __:new('Configuration', data)

        -- this will confirm set is calling the maybePrefixKey()
        instance.prefixKey = 'test-prefix'

        instance:set('test-key', 'test-value')

        __.arr
            :getMethod('set')
            :assertCalledOnceWith(data, 'test-prefix.test-key', 'test-value')
    end)
    :register()

-- @covers Configuration:setPrefixKey()
TestCase.new()
    :setName('setPrefixKey')
    :setTestClass(TestConfiguration)
    :setExecution(function()
        local instance = __:new('Configuration', {})

        lu.assertIsNil(instance.prefixKey)

        instance:setPrefixKey('test-prefix')

        lu.assertEquals('test-prefix', instance.prefixKey)
    end)
    :register()
-- end of TestConfiguration
