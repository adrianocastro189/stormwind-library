TestInterval = BaseTestClass:new()

-- @covers Interval:__construct()
TestCase.new()
    :setName('construct')
    :setTestClass(TestInterval)
    :setExecution(function(self)
        local instance = __:new('Interval')

        lu.assertNotNil(instance)
    end)
    :register()

-- @covers Interval:setCallback()
-- @covers Interval:setSeconds()
TestCase.new()
    :setName('setters')
    :setTestClass(TestInterval)
    :setExecution(function(data)
        local instance = __:new('Interval')

        lu.assertIsNil(instance.seconds)

        local result = instance
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        lu.assertEquals(instance, result)
        lu.assertEquals(60, instance.seconds)
        lu.assertEquals(TestInterval.testSetters, instance.callback)
    end)
    :register()

-- @covers Interval:start()
-- @covers Interval:stop()
TestCase.new()
    :setName('start and stop')
    :setTestClass(TestInterval)
    :setExecution(function()
        local instance = __:new('Interval')
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        instance:start()

        lu.assertNotNil(instance.ticker)
        lu.assertIsFalse(instance.ticker.canceled)

        instance:stop()

        lu.assertIsTrue(instance.ticker.canceled)
    end)
    :register()

-- @covers Interval:stop()
TestCase.new()
    :setName('stop without starting')
    :setTestClass(TestInterval)
    :setExecution(function()
        local instance = __:new('Interval')
            :setCallback(TestInterval.testSetters)
            :setSeconds(60)

        instance:stop()

        lu.assertIsNil(instance.ticker)
    end)
    :register()
-- end of TestInterval