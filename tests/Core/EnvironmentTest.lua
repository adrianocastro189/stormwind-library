TestEnvironment = BaseTestClass:new()
    -- @covers Environment:__construct()
    function TestEnvironment:testConstruct()
        lu.assertNotNil(__.environment)
    end
-- end of TestEnvironment