TestAddonProperties = BaseTestClass:new()
    -- @covers AddonProperties.lua
    function TestAddonProperties:testPropertiesAreSet()
        local library = StormwindLibrary.new({
            colors = {
                primary = 'test-primary-color',
                secondary = 'test-secondary-color'
            },
            command = 'test-command',
            name = 'TestSuite'
        })

        lu.assertEquals('test-primary-color', library.addon.colors.primary)
        lu.assertEquals('test-secondary-color', library.addon.colors.secondary)
        lu.assertEquals('test-command', library.addon.command)
        lu.assertEquals('TestSuite', library.addon.name)
    end

    -- @covers AddonProperties.lua
    function TestAddonProperties:testFailWhenMissingName()
        lu.assertErrorMsgContains('The addon property "name" is required to initialize Stormwind Library.', StormwindLibrary.new, {})
    end
-- end of TestAddonProperties