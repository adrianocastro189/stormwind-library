TestClassicTooltip = BaseTestClass:new()
    -- @covers ClassicTooltip:__construct()
    function TestClassicTooltip:testConstruct()
        local instance = __:new('ClassicTooltip')

        lu.assertNotNil(instance)

        -- test inheritance
        lu.assertIsFunction(instance.registerTooltipHandlers)
    end
-- end of TestClassicTooltip