TestEnvironment = BaseTestClass:new()
    -- @covers Environment:__construct()
    function TestEnvironment:testConstruct()
        lu.assertNotNil(__.environment)

        lu.assertEquals('classic', __.environment.constants.CLIENT_CLASSIC)
        lu.assertEquals('classic-era', __.environment.constants.CLIENT_CLASSIC_ERA)
        lu.assertEquals('retail', __.environment.constants.CLIENT_RETAIL)
        lu.assertEquals('test-suite', __.environment.constants.TEST_SUITE)
    end
-- end of TestEnvironment