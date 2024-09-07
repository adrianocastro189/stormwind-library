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
