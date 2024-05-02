TestEnvironment = BaseTestClass:new()
    -- @covers Environment:__construct()
    function TestEnvironment:testConstruct()
        lu.assertNotNil(__.environment)

        lu.assertEquals('classic', __.environment.constants.CLIENT_CLASSIC)
        lu.assertEquals('classic-era', __.environment.constants.CLIENT_CLASSIC_ERA)
        lu.assertEquals('retail', __.environment.constants.CLIENT_RETAIL)
        lu.assertEquals('test-suite', __.environment.constants.TEST_SUITE)
    end

    -- @covers Environment:getClientFlavor()
    function TestEnvironment:testGetClientFlavor()
    -- @TODO: Implement this method in EN3 <2024.05.02>
    end

    -- @covers Environment:getTocVersion()
    function TestEnvironment:testGetTocVersion()
        GetBuildInfo = function()
            -- example of GetBuildInfo() return values
            return 'x.y.z', 12345, '2024-05-02', 11502, '', '', 11502
        end

        lu.assertEquals(11502, __.environment:getTocVersion())
    end
-- end of TestEnvironment