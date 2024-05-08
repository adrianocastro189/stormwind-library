TestRetailTooltip = BaseTestClass:new()
    -- @covers RetailTooltip:__construct()
    function TestRetailTooltip:testConstruct()
        local instance = __:new('RetailTooltip')

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

        local instance = __:new('RetailTooltip')

        instance:registerTooltipHandlers()


        lu.assertIsFunction(hooks['item'])
        lu.assertIsFunction(hooks['unit'])
    end
-- end of TestRetailTooltip