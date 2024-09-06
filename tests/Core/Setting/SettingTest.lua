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
    :setExecution(function(data)
        local instance = __:new('Setting')

        instance.scope = data.scope

        lu.assertEquals(data.expectedResult, instance:getConfigurationMethod())
    end)
    :setScenarios({
        ['nil scope'] = {
            scope = nil,
            expectedResult = 'playerConfig',
        },
        ['empty scope'] = {
            scope = '',
            expectedResult = 'playerConfig',
        },
        ['invalid scope'] = {
            scope = 'invalid',
            expectedResult = 'playerConfig',
        },
        ['player scope'] = {
            scope = 'player',
            expectedResult = 'playerConfig',
        },
        ['global scope'] = {
            scope = 'global',
            expectedResult = 'config',
        },
    })
    :register()

-- @covers Setting:getFullyQualifiedId()
TestCase.new()
    :setName('getFullyQualifiedId')
    :setTestClass(TestSetting)
    :setExecution(function()
        local instance = __:new('Setting')

        instance.group = { id = 'groupId' }
        instance.id = 'settingId'

        lu.assertEquals('groupId.settingId', instance:getFullyQualifiedId())
    end)
    :register()

-- @covers Setting:getKey()
TestCase.new()
    :setName('getKey')
    :setTestClass(TestSetting)
    :setExecution(function()
        local instance = Spy
            .new(__:new('Setting'))
            :mockMethod('getFullyQualifiedId', function() return 'groupId.settingId' end)

        lu.assertEquals('__settings.groupId.settingId', instance:getKey())
    end)
    :register()

-- @covers Setting:getValue()
TestCase.new()
    :setName('getValue')
    :setTestClass(TestSetting)
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('Setting'))
            :mockMethod('getFullyQualifiedId', function() return 'groupId.settingId' end)

        instance.__ = Spy
            .new(__)
            :mockMethod('config', function() return 'globalValue' end)
            :mockMethod('playerConfig', function() return 'playerValue' end)
        
        instance.default = 'default'
        instance.scope = data.scope

        lu.assertEquals(data.expectedResult, instance:getValue())

        local method = instance.__:getMethod(data.scope == 'global' and 'config' or 'playerConfig')

        method:assertCalledOnceWith('__settings.groupId.settingId', 'default')
    end)
    :setScenarios({
        ['global scope'] = {
            scope = 'global',
            expectedResult = 'globalValue',
        },
        ['player scope'] = {
            scope = 'player',
            expectedResult = 'playerValue',
        },
    })
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
    :setExecution(function(data)
        local instance = Spy
            .new(__:new('Setting'))
            :mockMethod('getFullyQualifiedId', function() return 'groupId.settingId' end)
            :mockMethod('getValue', function() return data.oldValue end)

        instance.__ = Spy
            .new(__)
            :mockMethod('config')
            :mockMethod('playerConfig')

        instance.__.events:listen('SETTING_UPDATED', function(id, oldValue, newValue)
            instance.idArg = id
            instance.oldValueArg = oldValue
            instance.newValueArg = newValue
        end)
 
        instance.scope = data.scope

        instance:setValue(data.newValue)

        local method = instance.__:getMethod(data.scope == 'global' and 'config' or 'playerConfig')

        if data.shouldSet then
            method:assertCalledOnceWith({['__settings.groupId.settingId'] = data.newValue})
            lu.assertEquals('groupId.settingId', instance.idArg)
            lu.assertEquals(data.oldValue, instance.oldValueArg)
            lu.assertEquals(data.newValue, instance.newValueArg)
        else
            method:assertNotCalled()
            lu.assertIsNil(instance.idArg)
            lu.assertIsNil(instance.oldValueArg)
            lu.assertIsNil(instance.newValueArg)
        end
    end)
    :setScenarios({
        ['global scope'] = {
            scope = 'global',
            newValue = 'globalValue',
            oldValue = 'oldValue',
            shouldSet = true,
        },
        ['player scope'] = {
            scope = 'global',
            newValue = 'globalValue',
            oldValue = 'oldValue',
            shouldSet = true,
        },
        ['no changes'] = {
            scope = 'global',
            newValue = 'globalValue',
            oldValue = 'globalValue',
            shouldSet = false,
        },
    })
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
