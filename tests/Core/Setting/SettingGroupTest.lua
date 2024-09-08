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
    :setExecution(function()
    -- @TODO: Implement this method in SG1B <2024.09.07>
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
