TestInterval = BaseTestClass:new()
    -- @covers Interval:__construct()
    function TestInterval:testConstruct()
        local instance = __:new('Interval')

        lu.assertNotNil(instance)
    end
-- end of TestInterval