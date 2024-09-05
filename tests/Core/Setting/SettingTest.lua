TestSetting = BaseTestClass:new()

-- @covers Setting:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestSetting)
    :setExecution(function()
        local instance = __:new('Setting')
        lu.assertNotNil(instance)
    end)
    :register()
-- end of TestSetting