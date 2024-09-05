TestSetting = BaseTestClass:new()

-- @covers Setting:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestSetting)
    :setExecution(function()
        local instance = __:new('Setting')

        lu.assertNotNil(instance)
        lu.assertEquals(instance.accessibleByCommand, true)
        lu.assertEquals(instance.scope, 'player')
        lu.assertEquals(instance.type, 'string')
    end)
    :register()
-- end of TestSetting