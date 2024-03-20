--[[
The output structure controls everything that can be printed
in the Stormwind Library and also by the addons.
]]
local Output = {}
    Output.__index = Output
    Output.__ = self

    --[[
    Output constructor.
    ]]
    function Output.__construct()
        return setmetatable({}, Output)
    end
-- end of Output

-- sets the unique library output instance
self.output = Output.__construct()

-- allows Output to be instantiated, very useful for testing
self:addClass('Output', Output)