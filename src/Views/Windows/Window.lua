--[[--
The Window class is the base class for all windows in the library.

A window in this context is a standard frame that makes use of the World of
Warcraft CreateFrame function, but with some additional features: a title
bar that can move the window, a close button, a resize button at the bottom,
a content area with a scroll bar, plus a few other.

The motivation behind this class is to provide a simple way to create
windows, considering that the CreateFrame function is a bit cumbersome to
use, and that the standard window features can be enough for most addons.

It's necessary to note that this class is not as flexible as the CreateFrame
function, and that it's not meant to replace it. It's just a simple way to
create a basic window with some standard features. And if the addon developer
needs more flexibility, it's possible to extend this class to override some
methods and add new features.

@classmod Views.Windows.Window
]]
local Window = {}
    Window.__index = Window
    Window.__ = self
    self:addClass('Window', Window)

    --[[--
    Window constructor.

    When built with an id and the library is created with the data property,
    the window will be capable to persist its position, size, and other user
    preferences.

    @param string id The window identifier, which is used mostly to persist
                     information about the window, like its position and size
    ]]
    function Window.__construct(id)
        local self = setmetatable({}, Window)

        self.firstPosition = {point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0}
        self.firstSize = {width = 128, height = 128}
        self.firstVisibility = true
        self.id = id

        return self
    end

    --[[--
    Creates the window frame if it doesn't exist yet.

    @treturn Views.Windows.Window The window instance, for method chaining
    ]]
    function Window:create()
        if self.window then return self end

        self.window = self:createFrame()

        self:createTitleBar()
        self:createFooter()
        self:createScrollbar()
        self:createContentFrame()
        self:setWindowPositionOnCreation()
        self:setWindowSizeOnCreation()
        self:setWindowVisibilityOnCreation()

        return self
    end

    --[[--
    Creates a close button in the title bar.

    This method shouldn't be called directly. It's considered a complement
    to the createTitleBar() method.

    @local

    @treturn table The button created by CreateFrame
    ]]
    function Window:createCloseButton()
        local button = CreateFrame('Button', nil, self.titleBar, 'UIPanelCloseButton')
        button:SetPoint('RIGHT', self.titleBar, 'RIGHT', -5, 0)
        button:SetScript('OnClick', function()
            self:setVisibility(false)
        end)

        self.closeButton = button

        return self.closeButton
    end

    --[[--
    Creates the content frame, where the window's content will be placed.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local

    @treturn table The content frame created by CreateFrame
    ]]
    function Window:createContentFrame()
        local contentFrame = CreateFrame('Frame', nil, self.scrollbar)
        contentFrame:SetSize(self.scrollbar:GetWidth(), self.scrollbar:GetHeight())
        self.scrollbar:SetScrollChild(contentFrame)

        self.contentFrame = contentFrame

        return self.contentFrame
    end

    --[[--
    Creates a footer bar that contains a resize button.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local

    @treturn table The footer bar frame created by CreateFrame
    ]]
    function Window:createFooter()
        local frame = CreateFrame('Frame', nil, self.window, 'BackdropTemplate')
        frame:SetPoint('BOTTOMLEFT', self.window, 'BOTTOMLEFT', 0, 0)
        frame:SetPoint('BOTTOMRIGHT', self.window, 'BOTTOMRIGHT', 0, 0)
        frame:SetHeight(35)
        frame:SetBackdrop({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = {left = 4, right = 4, top = 4, bottom = 4},
        })
        frame:SetBackdropColor(0, 0, 0, .8)

        self.footer = frame

        self:createResizeButton()

        return self.footer
    end

    --[[--
    This is just a facade method to call World of Warcraft's CreateFrame.

    @local

    @see Views.Windows.Window.create

    @treturn table The window frame created by CreateFrame
    ]]
    function Window:createFrame()
        local frame = CreateFrame('Frame', nil, UIParent, 'BackdropTemplate')

        frame:SetBackdrop({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = {left = 4, right = 4, top = 4, bottom = 4},
        })
        frame:SetBackdropColor(0, 0, 0, .5)
        frame:SetBackdropBorderColor(0, 0, 0, 1)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:SetResizable(true)
        frame:SetScript('OnSizeChanged', function(target)
            local width, height = target:GetWidth(), target:GetHeight()
            if width < 100 then target:SetWidth(100) end
            if height < 100 then target:SetHeight(100) end

            self:storeWindowSize()
        end)

        return frame
    end

    --[[--
    Creates a resize button in the footer bar.

    This method shouldn't be called directly. It's considered a complement
    to the createFooter() method.

    @local

    @treturn table The button created by CreateFrame
    ]]
    function Window:createResizeButton()
        local button = CreateFrame('Button', nil, self.footer)
        button:SetPoint('RIGHT', self.footer, 'RIGHT', -10, 0)
        button:SetSize(20, 20)
        button:SetNormalTexture('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up')
        button:SetHighlightTexture('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight')
        button:SetScript('OnMouseDown', function(mouse, mouseButton)
            if mouseButton == 'LeftButton' then
                self.window:StartSizing('BOTTOMRIGHT')
                mouse:GetHighlightTexture():Hide()
            end
        end)
        button:SetScript('OnMouseUp', function(mouse)
            self.window:StopMovingOrSizing()
            mouse:GetHighlightTexture():Show()
        end)

        self.resizeButton = button

        return self.resizeButton
    end

    --[[--
    Creates a scrollbar to the window's content area.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local

    @treturn table The scrollbar frame created by CreateFrame
    ]]
    function Window:createScrollbar()
        local scrollbar = CreateFrame('ScrollFrame', nil, self.window, 'UIPanelScrollFrameTemplate')
        scrollbar:SetPoint('TOP', self.titleBar, 'BOTTOM', 0, -5)
        scrollbar:SetPoint('BOTTOM', self.footer, 'TOP', 0, 5)
        scrollbar:SetPoint('LEFT', self.window, 'LEFT', 5, 0)
        scrollbar:SetPoint('RIGHT', self.window, 'RIGHT', -35, 0)

        self.scrollbar = scrollbar

        return self.scrollbar
    end

    --[[--
    Creates a title bar that contains a title and a close button.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local

    @treturn table The title bar frame created by CreateFrame
    ]]
    function Window:createTitleBar()
        local frame = CreateFrame('Frame', nil, self.window, 'BackdropTemplate')

        frame:SetPoint('TOPLEFT', self.window, 'TOPLEFT', 0, 0)
        frame:SetPoint('TOPRIGHT', self.window, 'TOPRIGHT', 0, 0)
        frame:SetHeight(35)
        frame:SetBackdrop({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = {left = 4, right = 4, top = 4, bottom = 4},
        })
        frame:SetBackdropColor(0, 0, 0, .8)
        frame:SetScript('OnMouseDown', function(mouse, mouseButton)
            if mouseButton == 'LeftButton' then
                self.window:StartMoving()
            end
        end)
        frame:SetScript('OnMouseUp', function(mouse, mouseButton)
            if mouseButton == 'LeftButton' then
                self.window:StopMovingOrSizing()
                self:storeWindowPoint()
            end
        end)

        self.titleBar = frame

        self:createCloseButton()
        self:createTitleText()

        return self.titleBar
    end

    --[[--
    Creates the title text in the title bar.

    This method shouldn't be called directly. It's considered a complement
    to the createTitleBar() method.

    @local

    @treturn table The title text frame created by CreateFrame
    ]]
    function Window:createTitleText()
        local frame = self.titleBar:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        frame:SetPoint('LEFT', self.titleBar, 'LEFT', 10, 0)
        frame:SetText(self.title)

        self.titleText = frame

        return self.titleText
    end

    --[[--
    Gets a window property using the library configuration instance.

    This method is used internally by the library to persist the window's
    state. It's not meant to be called by addons.

    @local

    @tparam string key The property key

    @treturn any The property value
    ]]
    function Window:getProperty(key)
        return self.__:config(self:getPropertyKey(key))
    end

    --[[--
    Gets the property key used by the window instance to persist its state
    using the library configuration instance.

    A property key is a result of the concatenation of a static prefix, this
    window's id, and the key parameter.

    This method is used internally by the library to persist the window's
    state. It's not meant to be called by addons.

    @local

    @tparam string key The property key

    @treturn string The property key used by the window instance to persist
                    its state using the library configuration instance
    ]]
    function Window:getPropertyKey(key)
        return 'windows.' .. self.id .. '.' .. key
    end

    --[[--
    Gets the window's frame instance.

    This method has effect only after Window:create() is called.

    @treturn table The window frame instance
    ]]
    function Window:getWindow()
        return self.window
    end

    --[[--
    Hides the window.

    This is just a facade method to call the Hide method on the window frame.
    However, it shouldn't be used by addons as an internal method. Use
    setVisibility(false) instead.

    @local
    @see Views.Windows.Window.setVisibility
    ]]
    function Window:hide()
        self.window:Hide()
    end

    --[[--
    Determines if the window is persisting its state.

    A window is considered to be persisting its state if it has an id and the
    library is created with a configuration set.

    @treturn boolean true if the window is persisting its state, false otherwise
    ]]
    function Window:isPersistingState()
        return self.__.str:isNotEmpty(self.id) and self.__:isConfigEnabled()
    end

    --[[--
    Sets the window's first position.

    The first position is the position that the window will have when it's
    first created. If the player moves the window and this window is
    persisting its state, this property will be ignored.

    Because this class represents a window that's not tied to any specific
    frame, the relativeTo parameter will be omitted. The window will always
    be created with a nil relativeTo parameter.

    @tparam table position The position table, with the keys point, relativePoint, xOfs, and yOfs

    @treturn Views.Windows.Window The window instance, for method chaining

    @usage
        window:setFirstSize({point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0})
    ]]
    function Window:setFirstPosition(position)
        self.firstPosition = position
        return self
    end

    --[[--
    Sets the window's first size.

    The first size is the size that the window will have when it's first
    created. If the player resizes the window and this window is persisting
    its state, this property will be ignored.

    @tparam table size The size table, with the keys width and height

    @treturn Views.Windows.Window The window instance, for method chaining

    @usage
        window:setFirstSize({width = 200, height = 100})
    ]]
    function Window:setFirstSize(size)
        self.firstSize = size
        return self
    end

    --[[--
    Sets the window's first visibility.

    The first visibility is the visibility that the window will have when
    it's first created. If the player hides the window and this window is
    persisting its state, this property will be ignored.

    @tparam boolean visibility The first visibility state

    @treturn Views.Windows.Window The window instance, for method chaining

    @usage
        window:setFirstVisibility(false)
    ]]
    function Window:setFirstVisibility(visibility)
        self.firstVisibility = visibility
        return self
    end

    --[[--
    Sets a window property using the library configuration instance.

    This method is used internally by the library to persist the window's
    state. It's not meant to be called by addons.

    @local
    
    @tparam string key The property key
    @param any value The property value
    ]]
    function Window:setProperty(key, value)
        self.__:config({
            [self:getPropertyKey(key)] = value
        })
    end

    --[[--
    Sets the window title.

    The window title will be displayed in the title bar, the same one that
    users can click and drag to move the window.

    @param string title The window title
    @treturn Views.Windows.Window The window instance, for method chaining

    @usage
        window:setTitle('My Window Title')
    ]]
    function Window:setTitle(title)
        self.title = title
        return self
    end

    --[[--
    Sets the window visibility.

    This is the method to be called by addons to show or hide the window,
    instead of the local show() and hide(), considering that it not only
    controls the window visibility but also persists the state if the window
    is persisting its state.

    @tparam boolean visible The visibility state

    @treturn Views.Windows.Window The window instance, for method chaining
    --]]
    function Window:setVisibility(visible)
        if visible then self:show() else self:hide() end

        if self:isPersistingState() then self:setProperty('visibility', visible) end

        return self
    end

    --[[--
    Sets the window position on creation.

    This method is called when the window is created, and it sets the window
    position to the first position set by the developer or the persisted
    position if it's found.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local
    ]]
    function Window:setWindowPositionOnCreation()
        local point = self.firstPosition.point
        local relativeTo = self.firstPosition.relativeTo
        local relativePoint = self.firstPosition.relativePoint
        local xOfs = self.firstPosition.xOfs
        local yOfs = self.firstPosition.yOfs

        if self:isPersistingState() then
            point = self:getProperty('position.point') or point
            relativeTo = self:getProperty('position.relativeTo') or relativeTo
            relativePoint = self:getProperty('position.relativePoint') or relativePoint
            xOfs = self:getProperty('position.xOfs') or xOfs
            yOfs = self:getProperty('position.yOfs') or yOfs
        end

        self.window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --[[--
    Sets the window size on creation.

    This method is called when the window is created, and it sets the window
    size to the first size set by the developer or the persisted size if it's
    found.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local
    ]]
    function Window:setWindowSizeOnCreation()
        local w = self.firstSize.width
        local h = self.firstSize.height

        if self:isPersistingState() then
            h = self:getProperty('size.height') or h
            w = self:getProperty('size.width')  or w
        end

        self.window:SetSize(w, h)
    end

    --[[--
    Sets the window visibility on creation.

    This method is called when the window is created, and it sets the window
    visibility to the first state set by the developer or the persisted
    state if it's found.

    This method shouldn't be called directly. It's considered a complement
    to the create() method.

    @local
    ]]
    function Window:setWindowVisibilityOnCreation()
        if self.firstVisibility then
            self.window:Show()
            return
        end

        self.window:Hide()
    end

    --[[--
    Shows the window.

    This is just a facade method to call the Show method on the window frame.
    However, it shouldn't be used by addons as an internal method. Use
    setVisibility(true) instead.

    @local
    @see Views.Windows.Window.setVisibility
    ]]
    function Window:show()
        self.window:Show()
    end

    --[[--
    Stores the window's point in the configuration instance if the window is
    persisting its state.

    This method is used internally by the library to persist the window's
    state. It's not meant to be called by addons.

    @local
    ]]
    function Window:storeWindowPoint()
        if not self:isPersistingState() then return end

        local point, relativeTo, relativePoint, xOfs, yOfs = self.window:GetPoint()

        self:setProperty('position.point', point)
        self:setProperty('position.relativeTo', relativeTo)
        self:setProperty('position.relativePoint', relativePoint)
        self:setProperty('position.xOfs', xOfs)
        self:setProperty('position.yOfs', yOfs)
    end

    --[[--
    Stores the window's size in the configuration instance if the window is
    persisting its state.

    This method is used internally by the library to persist the window's
    state. It's not meant to be called by addons.

    @local
    ]]
    function Window:storeWindowSize()
        if not self:isPersistingState() then return end

        local width, height = self.window:GetWidth(), self.window:GetHeight()

        self:setProperty('size.height', height)
        self:setProperty('size.width', width)
    end
-- end of Window