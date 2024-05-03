TestAbstractTooltip = BaseTestClass:new()
    -- @covers AbstractTooltip:__construct()
    function TestAbstractTooltip:testConstruct()
        local instance = __:new('AbstractTooltip')

        lu.assertNotNil(instance)
    end
-- end of TestAbstractTooltip