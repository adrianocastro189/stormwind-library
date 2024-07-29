TestVersion = BaseTestClass:new()
    -- @covers StormwindLibrary:getVersionedNameLabel()
    function TestVersion:testGetVersionedNameLabel()
        local function execution(version, expectedOutput)
            __.addon.version = version

            lu.assertEquals(expectedOutput, __:getVersionedNameLabel())
        end

        __.addon.name = 'TestAddon'

        -- version is set
        execution('1.11.0', 'TestAddon v1.11.0')

        -- version is not set
        execution(nil, 'TestAddon')
    end

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