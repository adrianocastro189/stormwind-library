TestSettingGroup = BaseTestClass:new()

-- @covers SettingGroup:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
        local instance = __:new('SettingGroup')

        lu.assertNotNil(instance)
        lu.assertEquals({}, instance.settings)
    end)
    :register()

-- @covers SettingGroup:addSetting()
TestCase.new()
    :setName('addSetting')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
    -- @TODO: Implement this method in SG2 <2024.09.07>
    end)
    :register()

-- @covers SettingGroup:all()
TestCase.new()
    :setName('all')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
    -- @TODO: Implement this method in SG1A <2024.09.07>
    end)
    :register()

-- @covers SettingGroup:allAccessibleByCommand()
TestCase.new()
    :setName('allAccessibleByCommand')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
    -- @TODO: Implement this method in SG1B <2024.09.07>
    end)
    :register()

-- @covers SettingGroup:getSetting()
TestCase.new()
    :setName('getSetting')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
    -- @TODO: Implement this method in SG3 <2024.09.07>
    end)
    :register()

-- @covers SettingGroup:getSettingValue()
TestCase.new()
    :setName('getSettingValue')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
    -- @TODO: Implement this method in SG4 <2024.09.07>
    end)
    :register()

-- @covers SettingGroup:hasSettings()
TestCase.new()
    :setName('hasSettings')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
    -- @TODO: Implement this method in SG1A <2024.09.07>
    end)
    :register()

-- @covers SettingGroup:setId()
-- @covers SettingGroup:setLabel()
TestCase.new()
    :setName('setters')
    :setTestClass(TestSettingGroup)
    :setExecution(function(data)
        local instance = __:new('SettingGroup')

        local setter = 'set' .. __.str:ucFirst(data.property)

        local result = instance[setter](instance, 'value')

        lu.assertEquals(instance, result)

        lu.assertEquals('value', instance[data.property])
    end)
    :setScenarios({
        ['id'] = { property = 'id' },
        ['label'] = { property = 'label' },
    })
    :register()
-- end of TestSettingGroup
