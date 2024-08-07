-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

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
    -- @covers Interval:stop()
    function TestInterval:testStartAndStop()
        local instance = __:new('Interval')
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        instance:start()

        lu.assertNotNil(instance.ticker)
        lu.assertIsFalse(instance.ticker.canceled)

        instance:stop()

        lu.assertIsTrue(instance.ticker.canceled)
    end

    -- @covers Interval:stop()
    function TestInterval:testStopWithoutStarting()
        local instance = __:new('Interval')
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        instance:stop()

        lu.assertIsNil(instance.ticker)
    end
-- end of TestInterval