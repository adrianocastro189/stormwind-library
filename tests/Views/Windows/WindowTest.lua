TestWindow = BaseTestClass:new()
    -- @covers Window:__construct()
    function TestWindow:testConstruct()
        local instance = __:new('Window')

        lu.assertNotNil(instance)
    end
-- end of TestWindow