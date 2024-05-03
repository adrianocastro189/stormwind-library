--[[--
The default implementation of the AbstractTooltip class for the Classic
clients.

@classmod Facades.ClassicTooltip
]]
local ClassicTooltip = {}
    ClassicTooltip.__index = ClassicTooltip
    -- ClassicTooltip inherits from AbstractTooltip
    setmetatable(ClassicTooltip, AbstractTooltip)
    self:addClass('ClassicTooltip', ClassicTooltip)

    --[[--
    ClassicTooltip constructor.
    ]]
    function ClassicTooltip.__construct()
        return setmetatable({}, ClassicTooltip)
    end
-- end of ClassicTooltip