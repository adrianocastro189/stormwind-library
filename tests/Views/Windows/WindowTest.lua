TestWindow = BaseTestClass:new()
    -- @covers Window:__construct()
    function TestWindow:testConstruct()
        local instance = __:new('Window', 'test-id')

        lu.assertNotNil(instance)
        lu.assertEquals('test-id', instance.id)
        lu.assertEquals({width = 128, height = 128}, instance.firstSize)
        lu.assertEquals({point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0}, instance.firstPosition)
        lu.assertTrue(instance.firstVisibility)
    end

    -- @covers Window:create()
    function TestWindow:testCreate()
        local function execution(existingWindow, shouldCallCreateFrame)
            local createContentFrameInvoked = false
            local createFooterInvoked = false
            local createFrameInvoked = false
            local createScrollbarInvoked = false
            local createTitleBarInvoked = false
            local setWindowPositionOnCreationInvoked = false
            local setWindowSizeOnCreationInvoked = false
            local setWindowVisibilityOnCreationInvoked = false

            local instance = __:new('Window', 'test-id')
            instance.createContentFrame = function() createContentFrameInvoked = true end
            instance.createFooter = function() createFooterInvoked = true end
            instance.createFrame = function() createFrameInvoked = true end
            instance.createScrollbar = function() createScrollbarInvoked = true end
            instance.createTitleBar = function() createTitleBarInvoked = true end
            instance.setWindowPositionOnCreation = function() setWindowPositionOnCreationInvoked = true end
            instance.setWindowSizeOnCreation = function() setWindowSizeOnCreationInvoked = true end
            instance.setWindowVisibilityOnCreation = function() setWindowVisibilityOnCreationInvoked = true end
            
            instance.window = existingWindow

            instance:create()

            lu.assertEquals(shouldCallCreateFrame, createContentFrameInvoked)
            lu.assertEquals(shouldCallCreateFrame, createFooterInvoked)
            lu.assertEquals(shouldCallCreateFrame, createFrameInvoked)
            lu.assertEquals(shouldCallCreateFrame, createScrollbarInvoked)
            lu.assertEquals(shouldCallCreateFrame, createTitleBarInvoked)
            lu.assertEquals(shouldCallCreateFrame, setWindowPositionOnCreationInvoked)
            lu.assertEquals(shouldCallCreateFrame, setWindowSizeOnCreationInvoked)
            lu.assertEquals(shouldCallCreateFrame, setWindowVisibilityOnCreationInvoked)
        end

        execution(nil, true)
        execution({}, false)
    end

    -- @covers Window:createCloseButton()
    function TestWindow:testCreateCloseButton()
        local instance = __:new('Window', 'test-id')

        instance.titleBar, instance.window = CreateFrame(), CreateFrame()

        lu.assertIsNil(instance.closeButton)

        local result = instance:createCloseButton()

        lu.assertEquals({
            relativeFrame = instance.titleBar,
            relativePoint = 'RIGHT',
            xOfs = -5,
            yOfs = 0
        }, result.points['RIGHT'])

        lu.assertEquals(instance.closeButton, result)
    end

    -- @covers Window:createContentFrame
    function TestWindow:testCreateContentFrame()
        local setScrollChildArg = nil

        local instance = __:new('Window', 'test-id')

        instance.scrollbar = CreateFrame()
        instance.scrollbar.GetWidth = function() return 10 end
        instance.scrollbar.GetHeight = function() return 10 end
        instance.scrollbar.SetScrollChild = function(self, contentFrame) setScrollChildArg = contentFrame end

        local result = instance:createContentFrame()

        lu.assertEquals(10, result.width)
        lu.assertEquals(10, result.height)
        lu.assertEquals(instance.contentFrame, setScrollChildArg)
        lu.assertEquals(instance.contentFrame, result)
    end

    -- @covers Window:createFooter()
    function TestWindow:testCreateFooter()
        local createResizeButtonInvoked = false

        local instance = __:new('Window', 'test-id')
        instance.createResizeButton = function() createResizeButtonInvoked = true end
        instance.window = CreateFrame()

        lu.assertIsNil(instance.footer)

        local result = instance:createFooter()

        lu.assertEquals({
            relativeFrame = instance.window,
            relativePoint = 'BOTTOMLEFT',
            xOfs = 0,
            yOfs = 0
        }, result.points['BOTTOMLEFT'])
        lu.assertEquals({
            relativeFrame = instance.window,
            relativePoint = 'BOTTOMRIGHT',
            xOfs = 0,
            yOfs = 0
        }, result.points['BOTTOMRIGHT'])
        lu.assertEquals(35, result.height)
        lu.assertEquals({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = {left = 4, right = 4, top = 4, bottom = 4},
        }, result.backdrop)
        lu.assertEquals({0, 0, 0, .8}, result.backdropColor)
        lu.assertIsTrue(createResizeButtonInvoked)

        lu.assertEquals(instance.footer, result)
    end

    -- @covers Window:createFrame()
    function TestWindow:testCreateFrame()
        local instance = __:new('Window', 'test-id')

        local result = instance:createFrame()

        lu.assertEquals({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = {left = 4, right = 4, top = 4, bottom = 4},
        }, result.backdrop)
        lu.assertEquals({0, 0, 0, .5}, result.backdropColor)
        lu.assertEquals({0, 0, 0, 1}, result.backdropBorderColor)
        lu.assertTrue(result.movable)
        lu.assertTrue(result.mouseEnabled)
        lu.assertTrue(result.resizable)
    end

    -- @covers Window:createResizeButton()
    function TestWindow:testCreateResizeButton()
        local instance = __:new('Window', 'test-id')

        instance.footer, instance.window = CreateFrame(), CreateFrame()

        lu.assertIsNil(instance.resizeButton)

        local result = instance:createResizeButton()

        lu.assertEquals({
            relativeFrame = instance.footer,
            relativePoint = 'RIGHT',
            xOfs = -10,
            yOfs = 0
        }, result.points['RIGHT'])
        lu.assertEquals(20, result.width)
        lu.assertEquals(20, result.height)
        lu.assertEquals('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up', result.normalTexture)
        lu.assertEquals('Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight', result.highlightTexture)

        lu.assertEquals(instance.resizeButton, result)
    end

    -- @covers Window:createScrollbar()
    function TestWindow:testCreateScrollbar()
        local instance = __:new('Window', 'test-id')

        instance.footer = CreateFrame()
        instance.titleBar = CreateFrame()
        instance.window = CreateFrame()

        local result = instance:createScrollbar()

        lu.assertEquals({
            relativeFrame = instance.titleBar,
            relativePoint = 'BOTTOM',
            xOfs = 0,
            yOfs = -5,
        }, result.points['TOP'])
        lu.assertEquals({
            relativeFrame = instance.footer,
            relativePoint = 'TOP',
            xOfs = 0,
            yOfs = 5,
        }, result.points['BOTTOM'])
        lu.assertEquals({
            relativeFrame = instance.window,
            relativePoint = 'LEFT',
            xOfs = 5,
            yOfs = 0,
        }, result.points['LEFT'])
        lu.assertEquals({
            relativeFrame = instance.window,
            relativePoint = 'RIGHT',
            xOfs = -35,
            yOfs = 0,
        }, result.points['RIGHT'])

        lu.assertEquals(instance.scrollbar, result)
    end

    -- @covers Window:createTitleBar()
    function TestWindow:testCreateTitleBar()
        local createTitleTextInvoked = false
        local createCloseButtonInvoked = false

        local instance = __:new('Window', 'test-id')
        instance.createCloseButton = function() createCloseButtonInvoked = true end
        instance.createTitleText = function() createTitleTextInvoked = true end
        instance.window = {'test-window'}

        lu.assertIsNil(instance.titleBar)

        local result = instance:createTitleBar()

        lu.assertEquals({
            relativeFrame = instance.window,
            relativePoint = 'TOPLEFT',
            xOfs = 0,
            yOfs = 0
        }, result.points['TOPLEFT'])
        lu.assertEquals({
            relativeFrame = instance.window,
            relativePoint = 'TOPRIGHT',
            xOfs = 0,
            yOfs = 0
        }, result.points['TOPRIGHT'])
        lu.assertEquals(35, result.height)
        lu.assertEquals({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = {left = 4, right = 4, top = 4, bottom = 4},
        }, result.backdrop)
        lu.assertEquals({0, 0, 0, .8}, result.backdropColor)
        lu.assertIsTrue(createCloseButtonInvoked)
        lu.assertIsTrue(createTitleTextInvoked)

        lu.assertEquals(instance.titleBar, result)
    end

    -- @covers Window:createTitleText()
    function TestWindow:testCreateTitleText()
        local instance = __:new('Window', 'test-id')
        
        local titleTextFrame = CreateFrame()
        instance.title = 'test-title'
        instance.titleBar = {
            CreateFontString = function() return titleTextFrame end
        }

        lu.assertIsNil(instance.titleText)

        local result = instance:createTitleText()

        lu.assertEquals({
            relativeFrame = instance.titleBar,
            relativePoint = 'LEFT',
            xOfs = 10,
            yOfs = 0
        }, titleTextFrame.points['LEFT'])
        lu.assertEquals('test-title', titleTextFrame.text)

        lu.assertEquals(instance.titleText, result)
    end

    -- @covers Window:getWindow()
    function TestWindow:testGetWindow()
        local instance = __:new('Window', 'test-id')

        lu.assertIsNil(instance:getWindow())

        instance.window = {'test-window'}

        local result = instance:getWindow()

        lu.assertEquals(instance.window, result)
    end

    -- @covers Window:isPersistingState()
    function TestWindow:testIsPersistingState()
        local function execution(id, libraryHasConfigEnabled, expectedResult)
            local instance = __:new('Window', id)
            instance.__.isConfigEnabled = function() return libraryHasConfigEnabled end

            lu.assertEquals(expectedResult, instance:isPersistingState())
        end

        execution('test-id', true, true)
        execution('test-id', false, false)
        execution(nil, true, false)
        execution(nil, false, false)
        execution('', true, false)
    end

    -- @covers Window:setFirstPosition()
    function TestWindow:testSetFirstPosition()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setFirstPosition({point = 'TOP', relativePoint = 'TOP', xOfs = 10, yOfs = 10})

        lu.assertEquals({point = 'TOP', relativePoint = 'TOP', xOfs = 10, yOfs = 10}, instance.firstPosition)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setFirstSize()
    function TestWindow:testSetFirstSize()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setFirstSize({width = 200, height = 100})

        lu.assertEquals({width = 200, height = 100}, instance.firstSize)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setFirstVisibility()
    function TestWindow:testSetFirstVisibility()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setFirstVisibility(false)

        lu.assertFalse(instance.firstVisibility)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setTitle()
    function TestWindow:testSetTitle()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setTitle('test-title')

        lu.assertEquals('test-title', instance.title)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setWindowPositionOnCreation()
    function TestWindow:testSetWindowPositionOnCreation()
        local instance = __:new('Window', 'test-id')
        instance.firstPosition = {
            point = 'TOP',
            relativePoint = 'TOP',
            xOfs = 10,
            yOfs = 10
        }
        instance.window = CreateFrame()

        instance:setWindowPositionOnCreation()

        lu.assertEquals({
            relativeFrame = nil,
            relativePoint = 'TOP',
            xOfs = 10,
            yOfs = 10
        }, instance.window.points['TOP'])
    end

    -- @covers Window:setWindowVisibilityOnCreation()
    function TestWindow:testSetWindowVisibilityOnCreation()
        local function execution(firstVisibility, shouldCallShow, shouldCallHide)
            local instance = __:new('Window', 'test-id')
            instance.firstVisibility = firstVisibility
            instance.window = CreateFrame()

            instance.window.showInvoked = false
            instance.window.hideInvoked = false
    
            instance:setWindowVisibilityOnCreation()
    
            lu.assertEquals(shouldCallShow, instance.window.showInvoked)
            lu.assertEquals(shouldCallHide, instance.window.hideInvoked)
        end

        execution(true, true, false)
        execution(false, false, true)
    end
-- end of TestWindow