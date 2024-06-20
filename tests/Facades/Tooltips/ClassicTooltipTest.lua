TestClassicTooltip = BaseTestClass:new()
    -- helper method to instantiate the classic implementation
    function TestClassicTooltip:instance()
        __.environment.getClientFlavor = function () return __.environment.constants.CLIENT_CLASSIC end
        return __:new('Tooltip')
    end

    -- @covers ClassicTooltip:__construct()
    function TestClassicTooltip:testConstruct()
        local instance = self:instance()

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

        self:instance():registerTooltipHandlers()

        lu.assertIsFunction(hooks['OnTooltipSetItem'])
        lu.assertIsFunction(hooks['OnTooltipSetUnit'])
    end
-- end of TestClassicTooltip