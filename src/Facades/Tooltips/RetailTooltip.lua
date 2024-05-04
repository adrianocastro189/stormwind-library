--[[--
The default implementation of the AbstractTooltip class for the Retail
client.

@classmod Facades.RetailTooltip
]]
local RetailTooltip = {}
    RetailTooltip.__index = RetailTooltip
    -- RetailTooltip inherits from AbstractTooltip
    setmetatable(RetailTooltip, AbstractTooltip)
    self:addClass('RetailTooltip', RetailTooltip, self.environment.constants.TEST_SUITE)
    self:addClass('Tooltip', RetailTooltip, {
        self.environment.constants.CLIENT_RETAIL,
    })

    --[[--
    RetailTooltip constructor.
    ]]
    function RetailTooltip.__construct()
        return setmetatable({}, RetailTooltip)
    end

    --[[--
    Add tooltip post call with the TooltipDataProcessor.
    ]]
    function RetailTooltip:registerTooltipHandlers()
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
            self:onItemTooltipShow(tooltip);
        end)

        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
            self:onUnitTooltipShow(tooltip)
        end)
    end
-- end of RetailTooltip