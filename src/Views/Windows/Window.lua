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

        self.firstPosition = { point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0 }
        self.firstSize = { width = 128, height = 128 }
        self.firstVisibility = true
        self.id = id

        return self
    end

    --[[--
    Creates the window frame if it doesn't exist yet.

    @treturn table The window frame created by CreateFrame
    ]]
    function Window:create()
        if self.window then return self.window end

        self.window = self:createFrame()

        return self.window
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
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })

        frame:SetBackdropColor(0, 0, 0, .5)
        frame:SetBackdropBorderColor(0, 0, 0, 1)
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:SetResizable(true)

        return frame
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
        window:setFirstSize({ point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0 })
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
        window:setFirstSize({ width = 200, height = 100 })
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
-- end of Window