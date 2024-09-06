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

-- @covers Setting:getCommandHelpContent()
TestCase.new()
    :setName('getCommandHelpContent')
    :setTestClass(TestSetting)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('Setting'))
            :mockMethod('getFullyQualifiedId', function() return 'groupId.settingId' end)

        instance.type = 'type'
        instance.description = data.description

        local result = instance:getCommandHelpContent()

        lu.assertEquals(data.expectedOutput, result)
    end)
    :setScenarios({
        ['nil description'] = {
            description = nil,
            expectedOutput = 'groupId.settingId <type>',
        },
        ['empty description'] = {
            description = '',
            expectedOutput = 'groupId.settingId <type>',
        },
        ['with description'] = {
            description = 'description',
            expectedOutput = 'groupId.settingId <type> description',
        },
    })
    :register()

-- @covers Setting:getConfigurationMethod()
TestCase.new()
    :setName('getConfigurationMethod')
    :setTestClass(TestSetting)
    :setExecution(function()
        -- @TODO: Implement this method in SE3 <2024.09.05>
    end)
    :register()

-- @covers Setting:getFullyQualifiedId()
TestCase.new()
    :setName('getFullyQualifiedId')
    :setTestClass(TestSetting)
    :setExecution(function()
        -- @TODO: Implement this method in SE2 <2024.09.05>
    end)
    :register()

-- @covers Setting:getValue()
TestCase.new()
    :setName('getValue')
    :setTestClass(TestSetting)
    :setExecution(function()
        -- @TODO: Implement this method in SE4 <2024.09.05>
    end)
    :register()

-- @covers Setting:isTrue()
TestCase.new()
    :setName('isTrue')
    :setTestClass(TestSetting)
    :setExecution(function()
        -- @TODO: Implement this method in SE6 <2024.09.05>
    end)
    :register()

-- @covers Setting:setValue()
TestCase.new()
    :setName('setValue')
    :setTestClass(TestSetting)
    :setExecution(function()
        -- @TODO: Implement this method in SE5 <2024.09.05>
    end)
    :register()

-- @covers Setting:setAccessibleByCommand()
-- @covers Setting:setDefault()
-- @covers Setting:setDescription()
-- @covers Setting:setGroup()
-- @covers Setting:setScope()
-- @covers Setting:setType()
TestCase.new()
    :setName('setters')
    :setTestClass(TestSetting)
    :setExecution(function(data)
        local instance = __:new('Setting')

        local setter = 'set' .. __.str:ucFirst(data.property)

        local result = instance[setter](instance, 'value')

        lu.assertEquals(instance, result)

        lu.assertEquals('value', instance[data.property])
    end)
    :setScenarios({
        ['accessibleByCommand'] = { property = 'accessibleByCommand' },
        ['default'] = { property = 'default' },
        ['description'] = { property = 'description' },
        ['group'] = { property = 'group' },
        ['scope'] = { property = 'scope' },
        ['type'] = { property = 'type' },
    })
    :register()
-- end of TestSetting
