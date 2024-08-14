TestMinimapIcon = BaseTestClass:new()

-- @covers TestMinimapIcon:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestMinimapIcon)
    :setExecution(function()
        local instance = __:new('MinimapIcon')
        lu.assertNotNil(instance)
    end)
    :register()
-- end of TestMinimapIcon