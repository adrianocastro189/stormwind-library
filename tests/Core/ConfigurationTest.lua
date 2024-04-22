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
        -- @TODO: Implement this test <2024.04.22>
    end

    -- @covers Configuration:getOrInitialize()
    function TestConfiguration:testGetOrInitialize()
        -- @TODO: Implement this test <2024.04.22>
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