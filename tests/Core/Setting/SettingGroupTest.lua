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
        local instance = __:new('SettingGroup')

        lu.assertEquals({}, instance.settings)

        local setting = __:new('Setting'):setId('setting-id')

        lu.assertIsNil(setting.group)

        instance:addSetting(setting)

        lu.assertEquals(setting, instance.settings['setting-id'])
        lu.assertEquals(instance, setting.group)
    end)
    :register()

-- @covers SettingGroup:all()
TestCase.new()
    :setName('all')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
        local instance = __:new('SettingGroup')

        lu.assertEquals({}, instance:all())

        local settingA = __:new('Setting')
        local settingB = __:new('Setting')

        instance.settings = { settingA, settingB }

        lu.assertEquals({ settingA, settingB }, instance:all())
    end)
    :register()

-- @covers SettingGroup:allAccessibleByCommand()
TestCase.new()
    :setName('allAccessibleByCommand')
    :setTestClass(TestSettingGroup)
    :setExecution(function(data)
        local instance = __:new('SettingGroup')

        instance.settings = data.settings

        local accessibleSettings = instance:allAccessibleByCommand()

        lu.assertEquals(data.expectedResult, accessibleSettings)
    end)
    :setScenarios({
        ['empty settings'] = {
            settings = {},
            expectedResult = {},
        },
        ['non-accessible settings'] = function()
            local settingA = __:new('Setting')
            local settingB = __:new('Setting')

            settingA.isAccessibleByCommand = function() return false end
            settingB.isAccessibleByCommand = function() return false end

            return {
                settings = { ['a'] = settingA, ['b'] = settingB },
                expectedResult = {},
            }
        end,
        ['accessible settings'] = function()
            local settingA = __:new('Setting')
            local settingB = __:new('Setting')

            settingA.isAccessibleByCommand = function() return true end
            settingB.isAccessibleByCommand = function() return true end

            return {
                settings = { ['a'] = settingA, ['b'] = settingB },
                expectedResult = { ['a'] = settingA, ['b'] = settingB },
            }
        end,
        ['mixed settings'] = function()
            local settingA = __:new('Setting')
            local settingB = __:new('Setting')

            settingA.isAccessibleByCommand = function() return false end
            settingB.isAccessibleByCommand = function() return true end

            return {
                settings = { ['a'] = settingA, ['b'] = settingB },
                expectedResult = { ['b'] = settingB },
            }
        end,
    })
    :register()

-- @covers SettingGroup:getSetting()
TestCase.new()
    :setName('getSetting')
    :setTestClass(TestSettingGroup)
    :setExecution(function()
        local instance = __:new('SettingGroup')

        local setting = __:new('Setting'):setId('setting-id')

        instance:addSetting(setting)

        lu.assertEquals(setting, instance:getSetting('setting-id'))
        lu.assertIsNil(instance:getSetting('non-existent-setting-id'))
    end)
    :register()

-- @covers SettingGroup:getSettingValue()
TestCase.new()
    :setName('getSettingValue')
    :setTestClass(TestSettingGroup)
    :setExecution(function(data)
        local instance = __:new('SettingGroup')

        instance.settings = data.settings

        lu.assertEquals(data.expectedResult, instance:getSettingValue(data.settingId))
    end)
    :setScenarios({
        ['empty settings'] = {
            settings = {},
            settingId = 'setting-id',
            expectedResult = nil,
        },
        ['has value'] = function()
            local setting = Spy
                .new(__:new('Setting'):setId('setting-id'))
                :mockMethod('getValue', function() return 'value' end)

            return {
                settings = { ['setting-id'] = setting },
                settingId = 'setting-id',
                expectedResult = 'value',
            }
        end,
        ['value is falsy'] = function()
            local setting = Spy
                .new(__:new('Setting'):setId('setting-id'))
                :mockMethod('getValue', function() return false end)

            return {
                settings = { ['setting-id'] = setting },
                settingId = 'setting-id',
                expectedResult = false,
            }
        end,
        ['setting is invalid'] = function()
            local setting = Spy
                .new(__:new('Setting'):setId('setting-id'))
                :mockMethod('getValue', function() return false end)

            return {
                settings = { ['setting-id'] = setting },
                settingId = 'invalid-setting-id',
                expectedResult = nil,
            }
        end,
    })
    :register()

-- @covers SettingGroup:hasSettings()
TestCase.new()
    :setName('hasSettings')
    :setTestClass(TestSettingGroup)
    :setExecution(function(data)
        local instance = __:new('SettingGroup')

        instance.settings = data.settings

        lu.assertEquals(data.expectedResult, instance:hasSettings())
    end)
    :setScenarios({
        ['empty settings'] = {
            settings = {},
            expectedResult = false,
        },
        ['non-empty settings'] = {
            settings = { 'setting' },
            expectedResult = true,
        },
        ['indexed settings'] = {
            settings = { ['setting'] = 'setting' },
            expectedResult = true,
        },
    })
    :register()

-- @covers SettingGroup:hasSettingsAccessibleByCommand()
TestCase.new()
    :setName('hasSettingsAccessibleByCommand')
    :setTestClass(TestSettingGroup)
    :setExecution(function(data)
        local instance = __:new('SettingGroup')

        instance.settings = data.settings

        local hasSettingsAccessibleByCommand = instance:hasSettingsAccessibleByCommand()

        lu.assertEquals(data.expectedResult, hasSettingsAccessibleByCommand)
    end)
    :setScenarios({
        ['empty settings'] = {
            settings = {},
            expectedResult = false,
        },
        ['non-accessible settings'] = function()
            local settingA = __:new('Setting')
            local settingB = __:new('Setting')

            settingA.isAccessibleByCommand = function() return false end
            settingB.isAccessibleByCommand = function() return false end

            return {
                settings = { ['a'] = settingA, ['b'] = settingB },
                expectedResult = false,
            }
        end,
        ['accessible settings'] = function()
            local settingA = __:new('Setting')
            local settingB = __:new('Setting')

            settingA.isAccessibleByCommand = function() return true end
            settingB.isAccessibleByCommand = function() return true end

            return {
                settings = { ['a'] = settingA, ['b'] = settingB },
                expectedResult = true,
            }
        end,
        ['mixed settings'] = function()
            local settingA = __:new('Setting')
            local settingB = __:new('Setting')

            settingA.isAccessibleByCommand = function() return false end
            settingB.isAccessibleByCommand = function() return true end

            return {
                settings = { ['a'] = settingA, ['b'] = settingB },
                expectedResult = true,
            }
        end,
    })
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
