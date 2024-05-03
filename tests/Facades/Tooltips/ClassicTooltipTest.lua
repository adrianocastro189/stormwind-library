TestClassicTooltip = BaseTestClass:new()
    -- @covers ClassicTooltip:__construct()
    function TestClassicTooltip:testConstruct()
        local instance = __:new('ClassicTooltip')

        lu.assertNotNil(instance)

        -- test inheritance
        lu.assertIsFunction(instance.registerTooltipHandlers)
    end

    -- @covers ClassicTooltip:registerTooltipHandlers()
    function TestClassicTooltip:testRegisterTooltipHandlers()
        local hooks = {}

        GameTooltip = {
            HookScript = function(_, hookName, callback)
                hooks[hookName] = callback
            end
        }

        local instance = __:new('ClassicTooltip')

        instance:registerTooltipHandlers()

        lu.assertIsFunction(hooks['OnTooltipSetItem'])
        lu.assertIsFunction(hooks['OnTooltipSetUnit'])
    end
-- end of TestClassicTooltip