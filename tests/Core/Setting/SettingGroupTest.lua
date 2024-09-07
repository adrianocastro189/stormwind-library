TestSettingGroup = BaseTestClass:new()

-- @covers SettingGroup:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
        local instance = __:new('SettingGroup')

        lu.assertNotNil(instance)
    end)
    :register()
-- end of TestSettingGroup
