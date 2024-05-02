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
        local function execution(isTestEnvironment, cachedFlavor, tocVersion, expectedFlavor)
            _G['TEST_ENVIRONMENT'] = isTestEnvironment
            __.environment.clientFlavor = cachedFlavor
            __.environment.getTocVersion = function() return tocVersion end

            lu.assertEquals(expectedFlavor, __.environment:getClientFlavor())
        end

        -- test suite
        execution(true, nil, 0, 'test-suite')

        -- determined by toc version
        execution(false, nil, 19999, 'classic-era')
        execution(false, nil, 20000, 'classic')
        execution(false, nil, 100000, 'retail')

        -- cached value
        execution(false, 'cached', 19999, 'cached')
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