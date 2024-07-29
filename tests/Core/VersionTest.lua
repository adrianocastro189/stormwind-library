TestVersion = BaseTestClass:new()
    -- @covers StormwindLibrary:getVersionLabel()
    function TestVersion:testGetVersionLabel()
        local function execution(version, expectedOutput)
            __.addon.version = version

            lu.assertEquals(expectedOutput, __:getVersionLabel())
        end

        -- version is set
        execution('1.11.0', 'v1.11.0')

        -- version is not set
        execution(nil, nil)
    end