--[[--
The default implementation of the AbstractTooltip class for the Classic
clients.

@classmod Facades.ClassicTooltip
]]
local ClassicTooltip = {}
    ClassicTooltip.__index = ClassicTooltip
    self:addChildClass('Tooltip', ClassicTooltip, 'AbstractTooltip', {
        self.environment.constants.TEST_SUITE,
        self.environment.constants.CLIENT_CLASSIC_ERA,
        self.environment.constants.CLIENT_CLASSIC,
    })

    --[[--
    ClassicTooltip constructor.
    ]]
    function ClassicTooltip.__construct()
        return setmetatable({}, ClassicTooltip)
    end

    --[[--
    Hooks into the GameTooltip events to handle item and unit tooltips.

    This is the implementation of the AbstractTooltip:registerTooltipHandlers()
    abstract method that works with Classic clients.
    ]]
    function ClassicTooltip:registerTooltipHandlers()
        GameTooltip:HookScript('OnTooltipSetItem', function (tooltip)
            self:onItemTooltipShow(tooltip)
        end)

        GameTooltip:HookScript('OnTooltipSetUnit', function (tooltip)
            self:onUnitTooltipShow(tooltip)
        end)
    end
-- end of ClassicTooltip