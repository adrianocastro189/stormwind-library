--[[--
WindowPage represents a page in a window content area.

@TODO: Implement unit tests in WI5 <2024.07.17>
@TODO: Write a better LuaDoc block in WI5 <2024.07.17>

@classmod Views.Windows.WindowPage
]]
local WindowPage = {}
    WindowPage.__index = WindowPage
    WindowPage.__ = self
    self:addClass('WindowPage', WindowPage)

    --[[--
    WindowPage constructor.
    ]]
    function WindowPage.__construct()
        local self = setmetatable({}, WindowPage)

        -- add properties here

        return self
    end
-- end of WindowPage