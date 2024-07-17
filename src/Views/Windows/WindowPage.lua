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

    --[[--
    Positions the children frames inside the page.

    This is an internal method and it shouldn't be called by addons.

    @local
    --]]
    function WindowPage:positionContentChildFrames()
        -- sets the first relative frame the content frame itself
        -- but after the first child, the relative frame will be the last
        local lastRelativeTo = self
        local totalChildrenHeight = 0

        for _, child in ipairs(self.contentChildren) do
            child:SetParent(self)
            child:SetPoint('TOPLEFT', lastRelativeTo, lastRelativeTo == self and 'TOPLEFT' or 'BOTTOMLEFT', 0, 0)
            child:SetPoint('TOPRIGHT', lastRelativeTo, lastRelativeTo == self and 'TOPRIGHT' or 'BOTTOMRIGHT', 0, 0)

            lastRelativeTo = child
            totalChildrenHeight = totalChildrenHeight + child:GetHeight()
        end

        self:SetHeight(totalChildrenHeight)
    end

    --[[--
    Sets the page's content, which is a table of frames.

    The Stormwind Library Window Page was designed to accept a list of frames
    to compose its content.

    This method is used to populate the content frame with the frames passed
    in the frames parameter. The frames then will be positioned sequentially
    from top to bottom, with the first frame being positioned at the top and
    the last frame at the bottom. Their width will be the same as the content
    frame's width and will grow horizontally to the right if the whole
    page is resized.

    Please, read the library documentation for more information on how to
    work with the frames inside the page's content.

    @tparam table frames The list of frames to be placed inside the page

    @treturn Views.Windows.WindowPage The window page instance, for method chaining

    @usage
        local frameA = CreateFrame(...)
        local frameB = CreateFrame(...)
        local frameC = CreateFrame(...)

        page:setContent({frameA, frameB, frameC})
    ]]
    function WindowPage:setContent(frames)
        self.contentChildren = frames

        self:positionContentChildFrames()

        return self
    end
-- end of WindowPage