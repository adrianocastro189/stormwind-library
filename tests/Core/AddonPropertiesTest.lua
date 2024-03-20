TestAddonProperties = {}
    -- @covers AddonProperties.lua
    function TestAddonProperties:testPropertiesAreSet()
        local library = StormwindLibrary.new({
            command = 'test-command',
            name = 'TestSuite'
        })

        lu.assertEquals('test-command', library.addon.command)
        lu.assertEquals('TestSuite', library.addon.name)
    end

    -- @covers AddonProperties.lua
    function TestAddonProperties:testFailWhenMissingName()
        lu.assertErrorMsgContains('The addon property "name" is required to initialize Stormwind Library.', StormwindLibrary.new, {})
    end
-- end of TestAddonProperties