TestAbstractTooltip = BaseTestClass:new()
    -- @covers AbstractTooltip:__construct()
    function TestAbstractTooltip:testConstruct()
        local instance = __:new('AbstractTooltip')

        lu.assertNotNil(instance)
    end

    -- @covers AbstractTooltip:onItemTooltipShow()
    function TestAbstractTooltip:testOnItemTooltipShow()
        local function execution(tooltip, gameTooltip, shouldNotify, expectedItem)
            GameTooltip = gameTooltip
            local notifiedItem = nil
            
            __.events:listen('ITEM_TOOLTIP_SHOWN', function(item) notifiedItem = item end)

            __:new('AbstractTooltip'):onItemTooltipShow(tooltip)

            if shouldNotify then
                lu.assertEquals(notifiedItem, expectedItem)
            else
                lu.assertNil(notifiedItem)
            end
        end

        local mockItem = __
            :new('Item')
            :setName('test-item')

        local mockGameTooltip = { GetItem = function() return 'test-item' end }

        -- tooltip is nil
        execution(nil, mockGameTooltip, false, nil)

        -- tooltip is not a GameTooltip
        execution({}, mockGameTooltip, false, nil)

        -- tooltip is a GameTooltip
        execution(mockGameTooltip, mockGameTooltip, true, mockItem)
    end

    -- @covers AbstractTooltip:onUnitTooltipShow()
    function TestAbstractTooltip:testOnUnitTooltipShow()
        local function execution(tooltip, gameTooltip, shouldNotify)
            local unitTooltipShownNotified = false

            GameTooltip = gameTooltip
            
            __.events:listen('UNIT_TOOLTIP_SHOWN', function() unitTooltipShownNotified = true end)

            __:new('AbstractTooltip'):onUnitTooltipShow(tooltip)

            lu.assertEquals(unitTooltipShownNotified, shouldNotify)
        end

        local mockGameTooltip = {'game-tooltip'}

        -- tooltip is nil
        execution(nil, mockGameTooltip, false)

        -- tooltip is not a GameTooltip
        execution({}, mockGameTooltip, false)

        -- tooltip is a GameTooltip
        execution(mockGameTooltip, mockGameTooltip, true)
    end

    -- @covers AbstractTooltip:registerTooltipHandlers()
    function TestAbstractTooltip:testRegisterTooltipHandlersIsAbstract()
        local instance = __:new('AbstractTooltip')

        lu.assertErrorMsgContains('This is an abstract method and should be implemented by this class inheritances', function()
            instance:registerTooltipHandlers()
        end)
    end
-- end of TestAbstractTooltip