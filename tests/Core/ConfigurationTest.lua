TestConfiguration = BaseTestClass:new()
    -- @covers Configuration:__construct()
    function TestConfiguration:testConstruct()
        local savedVariable = {['test-property'] = 'test-value'}

        local instance = __:new('Configuration', savedVariable)

        lu.assertNotNil(instance)
        lu.assertEquals(instance.data, {})
    end

    -- @covers Configuration:get()
    function TestConfiguration:testGet()
        -- @TODO: Implement this test <2024.04.22>
    end

    -- @covers Configuration:getOrInitialize()
    function TestConfiguration:testGetOrInitialize()
        -- @TODO: Implement this test <2024.04.22>
    end

    -- @covers Configuration:set()
    function TestConfiguration:testSet()
        -- @TODO: Implement this test <2024.04.22>
    end
-- end of TestConfiguration