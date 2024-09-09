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

-- @covers Settings:all()
TestCase.new()
    :setName('all')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS1A <2024.09.09>
    end)
    :register()

-- @covers Settings:allAccessibleByCommand()
TestCase.new()
    :setName('allAccessibleByCommand')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS1B <2024.09.09>
    end)
    :register()

-- @covers Settings:hasSettings()
TestCase.new()
    :setName('hasSettings')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS1A <2024.09.09>
    end)
    :register()

-- @covers Settings:hasSettingsAccessibleByCommand()
TestCase.new()
    :setName('hasSettingsAccessibleByCommand')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS1B <2024.09.09>
    end)
    :register()

-- @covers Settings:mapFromAddonProperties()
TestCase.new()
    :setName('mapFromAddonProperties')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in AP2 <2024.09.09>
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

-- @covers Settings:setting()
TestCase.new()
    :setName('setting')
    :setTestClass(TestSettings)
    :setExecution(function()
        -- @TODO: Implement this method in SS5 <2024.09.09>
    end)
    :register()
-- end of Settings