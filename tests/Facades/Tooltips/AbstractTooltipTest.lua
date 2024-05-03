TestAbstractTooltip = BaseTestClass:new()
    -- @covers AbstractTooltip:__construct()
    function TestAbstractTooltip:testConstruct()
        local instance = __:new('AbstractTooltip')

        lu.assertNotNil(instance)
    end

    -- @covers AbstractTooltip:registerTooltipHandlers()
    function TestAbstractTooltip:testRegisterTooltipHandlersIsAbstract()
        local instance = __:new('AbstractTooltip')

        lu.assertErrorMsgContains('This is an abstract method and should be implemented by this class inheritances', function()
            instance:registerTooltipHandlers()
        end)
    end
-- end of TestAbstractTooltip