TestSettings = BaseTestClass:new()

-- @covers Settings:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestSettings)
    :setExecution(function()
        local instance = __:new('Settings')

        lu.assertEquals({}, instance.settingGroups)
        lu.assertNotNil(instance)
    end)
    :register()

-- @covers Settings:addSetting()
TestCase.new()
    :setName('addSetting')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS4 <2024.09.09>
    end)
    :register()

-- @covers Settings:addSettingGroup()
TestCase.new()
    :setName('addSettingGroup')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS2 <2024.09.09>
    end)
    :register()

-- @covers Settings:maybeAddGeneralGroup()
TestCase.new()
    :setName('maybeAddGeneralGroup')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS3 <2024.09.09>
    end)
    :register()
-- end of Settings