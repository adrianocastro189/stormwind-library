TestConfiguration = BaseTestClass:new()
    -- @covers Configuration:__construct()
    function TestConfiguration:testConstruct()
        local instance = __:new('Configuration')

        lu.assertNotNil(instance)
    end
-- end of TestConfiguration