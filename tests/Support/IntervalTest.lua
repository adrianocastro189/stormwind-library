TestInterval = BaseTestClass:new()
    -- @covers Interval:__construct()
    function TestInterval:testConstruct()
        local instance = __:new('Interval')

        lu.assertNotNil(instance)
    end

    -- @covers Interval:setSeconds()
    function TestInterval:testSetters()
        local instance = __:new('Interval')

        lu.assertIsNil(instance.seconds)

        local result = instance
            :setSeconds(60)

        lu.assertEquals(instance, result)
        lu.assertEquals(60, instance.seconds)
    end
-- end of TestInterval