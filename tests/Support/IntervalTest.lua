TestInterval = BaseTestClass:new()
    -- @covers Interval:__construct()
    function TestInterval:testConstruct()
        local instance = __:new('Interval')

        lu.assertNotNil(instance)
    end

    -- @covers Interval:setCallback()
    -- @covers Interval:setSeconds()
    function TestInterval:testSetters()
        local instance = __:new('Interval')

        lu.assertIsNil(instance.seconds)

        local result = instance
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        lu.assertEquals(instance, result)
        lu.assertEquals(60, instance.seconds)
        lu.assertEquals(TestInterval.testSetters, instance.callback)
    end

    -- @covers Interval:start()
    function TestInterval:testStart()
        local instance = __:new('Interval')
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        instance:start()

        lu.assertNotNil(instance.ticker)
        lu.assertIsFalse(instance.ticker.canceled)
    end
-- end of TestInterval