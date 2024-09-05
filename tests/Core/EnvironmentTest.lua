TestEnvironment = BaseTestClass:new()

-- @covers Environment:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestEnvironment)
    :setExecution(function()
        lu.assertNotNil(__.environment)

        lu.assertEquals('classic', __.environment.constants.CLIENT_CLASSIC)
        lu.assertEquals('classic-era', __.environment.constants.CLIENT_CLASSIC_ERA)
        lu.assertEquals('retail', __.environment.constants.CLIENT_RETAIL)
        lu.assertEquals('test-suite', __.environment.constants.TEST_SUITE)
    end)
    :register()

-- @covers Environment:getClientFlavor()
TestCase.new()
    :setName('getClientFlavor')
    :setTestClass(TestEnvironment)
    :setExecution(function(data)
        _G['TEST_ENVIRONMENT'] = data.isTestEnvironment
        __.environment.clientFlavor = data.cachedFlavor
        __.environment.getTocVersion = function() return data.tocVersion end

        lu.assertEquals(data.expectedFlavor, __.environment:getClientFlavor())
    end)
    :setScenarios({
        ['test suite'] = {
            isTestEnvironment = true,
            cachedFlavor = nil,
            tocVersion = 0,
            expectedFlavor = 'test-suite',
        },
        ['classic era'] = {
            isTestEnvironment = false,
            cachedFlavor = nil,
            tocVersion = 19999,
            expectedFlavor = 'classic-era',
        },
        ['classic'] = {
            isTestEnvironment = false,
            cachedFlavor = nil,
            tocVersion = 20000,
            expectedFlavor = 'classic',
        },
        ['retail'] = {
            isTestEnvironment = false,
            cachedFlavor = nil,
            tocVersion = 100000,
            expectedFlavor = 'retail',
        },
        ['cached'] = {
            isTestEnvironment = false,
            cachedFlavor = 'cached',
            tocVersion = 19999,
            expectedFlavor = 'cached',
        },
    })
    :register()

-- @covers Environment:getTocVersion()
TestCase.new()
    :setName('getTocVersion')
    :setTestClass(TestEnvironment)
    :setExecution(function()
        GetBuildInfo = function()
            -- example of GetBuildInfo() return values
            return 'x.y.z', 12345, '2024-05-02', 11502, '', '', 11502
        end

        lu.assertEquals(11502, __.environment:getTocVersion())
    end)
    :register()

--@covers Environment:inGame()
TestCase.new()
    :setName('inGame')
    :setTestClass(TestEnvironment)
    :setExecution(function()
        lu.assertIsFalse(__.environment:inGame())

        __.environment.getClientFlavor = function()
            return __.environment.constants.CLIENT_CLASSIC
        end

        lu.assertIsTrue(__.environment:inGame())
    end)
    :register()
-- end of TestEnvironment