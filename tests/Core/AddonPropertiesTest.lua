TestAddonProperties = BaseTestClass:new()

-- @covers AddonProperties.lua
TestCase.new()
    :setName('fail when missing name')
    :setTestClass(TestAddonProperties)
    :setExecution(function()
        lu.assertErrorMsgContains('The addon property "name" is required to initialize Stormwind Library.',
            StormwindLibrary.new, {})
    end)
    :register()

-- @covers AddonProperties.lua
TestCase.new()
    :setName('propertiesAreSet')
    :setTestClass(TestAddonProperties)
    :setExecution(function()
        local settings = {
            groups = {}
        }

        local library = StormwindLibrary.new({
            colors = {
                primary = 'test-primary-color',
                secondary = 'test-secondary-color'
            },
            command = 'test-command',
            data = 'temporary-addon-table',
            name = 'TestSuite',
            settings = settings,
            version = '1.0.0'
        })

        lu.assertEquals('test-primary-color', library.addon.colors.primary)
        lu.assertEquals('test-secondary-color', library.addon.colors.secondary)
        lu.assertEquals('test-command', library.addon.command)
        lu.assertEquals('temporary-addon-table', library.addon.data)
        lu.assertEquals(false, library.addon.inventory.track)
        lu.assertEquals(settings, library.addon.settings)
        lu.assertEquals('TestSuite', library.addon.name)
        lu.assertEquals('1.0.0', library.addon.version)
    end)
    :register()
-- end of TestAddonProperties
