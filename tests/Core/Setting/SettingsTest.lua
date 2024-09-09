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
        local settings = __:new('Settings')

        local settingA = __:new('Setting'):setId('setting-a')
        local settingB = __:new('Setting'):setId('setting-b')
        local settingC = __:new('Setting'):setId('setting-c')

        local settingGroup1 = __:new('SettingGroup')
        local settingGroup2 = __:new('SettingGroup')

        settingGroup1:addSetting(settingA)
        settingGroup1:addSetting(settingB)
        settingGroup2:addSetting(settingC)

        settings.settingGroups = {
            ['setting-group-1'] = settingGroup1,
            ['setting-group-2'] = settingGroup2,
        }

        local allSettings = settings:all()

        lu.assertIsTrue(__.arr:inArray(allSettings, settingA))
        lu.assertIsTrue(__.arr:inArray(allSettings, settingB))
        lu.assertIsTrue(__.arr:inArray(allSettings, settingC))
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

-- @covers Settings.maybeCreateLibraryInstance()
TestCase.new()
    :setName('maybeCreateLibraryInstance')
    :setTestClass(TestSettings)
    :setExecution(function(data)
        local class = __:getClass('Settings')

        class.__ = Spy
            .new(class.__)
            :mockMethod('isConfigEnabled', function() return data.isConfigEnabled end)

        class.maybeCreateLibraryInstance()

        lu.assertEquals(data.shouldCreateSettingsInstance, class.__.settings ~= nil)
        lu.assertEquals(data.shouldCreateSettingsInstance, type(class.__.setting) == "function")

        -- asserts that the library method works as a proxy
        if data.shouldCreateSettingsInstance then
            class.__.settings = Spy
                .new(class.__.settings)
                :mockMethod('setting')

            class.__:setting('groupId.settingId')

            class.__.settings
                :getMethod('setting')
                :assertCalledOnceWith('groupId.settingId')
        end
    end)
    :setScenarios({
        ['config not enabled'] = {
            isConfigEnabled = false,
            shouldCreateSettingsInstance = false,
        },
        ['config enabled'] = {
            isConfigEnabled = true,
            shouldCreateSettingsInstance = true,
        },
    })
    :register()

TestCase.new()
    :setName('onLoad callback')
    :setTestClass(TestSettings)
    :setExecution(function(data)
        local library = StormwindLibrary.new({
            name = 'temporary-library-instance',
            data = data.table,
        })

        lu.assertEquals(data.shouldCreateSettingsInstance, library.settings ~= nil)
    end)
    :setScenarios({
        ['data has no value'] = {
            table = nil,
            shouldCreateSettingsInstance = false,
        },
        ['data has value'] = {
            table = 'TestTable',
            shouldCreateSettingsInstance = true,
        },
    })
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