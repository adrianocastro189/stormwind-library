--[[--
WindowPage represents a page in a window content area.

@TODO: Implement unit tests in WI5 <2024.07.17>
@TODO: Write a better LuaDoc block in WI5 <2024.07.17>

@classmod Views.Windows.WindowPage
]]
local WindowPage = {}
    WindowPage.__index = WindowPage
    WindowPage.__ = self

    -- WindowPage inherits from World of Warcraft's Frame structure
    setmetatable(WindowPage, CreateFrame('Frame', nil, UIParent, 'BackdropTemplate'))
    self:addClass('WindowPage', WindowPage)

    --[[--
    WindowPage constructor.
    ]]
    function WindowPage.__construct(pageId)
        local self = setmetatable({}, WindowPage)

        self.pageId = pageId

        return self
    end
-- end of WindowPage