TestRetailTooltip = BaseTestClass:new()
    -- helper method to instantiate the classic implementation
    function TestRetailTooltip:instance()
        __.environment.getClientFlavor = function () return __.environment.constants.CLIENT_RETAIL end
        return __:new('Tooltip')
    end

    -- @covers RetailTooltip:__construct()
    function TestRetailTooltip:testConstruct()
        local instance = self:instance()

        lu.assertNotNil(instance)

        -- test inheritance
        lu.assertIsFunction(instance.registerTooltipHandlers)
    end

    -- @covers RetailTooltip:registerTooltipHandlers()
    function TestRetailTooltip:testRegisterTooltipHandlers()
        local hooks = {}

        Enum = {
            TooltipDataType = {
                Item = 'item',
                Unit = 'unit',
            }
        }

        TooltipDataProcessor = {
            AddTooltipPostCall = function(hookName, callback)
                hooks[hookName] = callback
            end
        }

        self:instance():registerTooltipHandlers()

        lu.assertIsFunction(hooks['item'])
        lu.assertIsFunction(hooks['unit'])
    end
-- end of TestRetailTooltip