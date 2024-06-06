TestContainer = BaseTestClass:new()
    -- @covers Container:__construct()
    function TestContainer:testConstruct()
        local instance = __:new('Container')

        lu.assertNotNil(instance)
    end
-- end of TestContainer