-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestAbstractTooltip = BaseTestClass:new()
    -- helper method to instantiate the abstract class
    function TestAbstractTooltip:instance()
        -- instantiating an abstract class here is ok for the sake of testing
        return __:getClass('AbstractTooltip').__construct()
    end

    -- @covers AbstractTooltip:__construct()
    function TestAbstractTooltip:testConstruct()
        local instance = self:instance()

        lu.assertNotNil(instance)

        -- test constants
        lu.assertEquals(instance.constants.TOOLTIP_ITEM_SHOWN, 'TOOLTIP_ITEM_SHOWN')
        lu.assertEquals(instance.constants.TOOLTIP_UNIT_SHOWN, 'TOOLTIP_UNIT_SHOWN')
    end

    -- @covers StormwindLibrary.tooltip
    function TestAbstractTooltip:testLibraryTooltipInstanceIsSet()
        lu.assertNotNil(__.tooltip)
    end

    -- @covers AbstractTooltip:onItemTooltipShow()
    function TestAbstractTooltip:testOnItemTooltipShow()
        local function execution(tooltip, gameTooltip, shouldNotify, expectedItem)
            GameTooltip = gameTooltip
            local notifiedItem = nil
            
            __.events:listen('TOOLTIP_ITEM_SHOWN', function(item) notifiedItem = item end)

            self:instance():onItemTooltipShow(tooltip)

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
            
            __.events:listen('TOOLTIP_UNIT_SHOWN', function() unitTooltipShownNotified = true end)

            -- instantiating an abstract class here is ok for the sake of testing
            self:instance():onUnitTooltipShow(tooltip)

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
        lu.assertErrorMsgContains('This is an abstract method and should be implemented by this class inheritances', function()
            self:instance():registerTooltipHandlers()
        end)
    end
-- end of TestAbstractTooltip