TestWindow = BaseTestClass:new()
    -- @covers Window:__construct()
    function TestWindow:testConstruct()
        local instance = __:new('Window', 'test-id')

        lu.assertNotNil(instance)
        lu.assertEquals('test-id', instance.id)
        lu.assertEquals({ width = 128, height = 128 }, instance.firstSize)
        lu.assertEquals({ point = 'CENTER', relativePoint = 'CENTER', xOfs = 0, yOfs = 0 }, instance.firstPosition)
        lu.assertTrue(instance.firstVisibility)
    end

    -- @covers Window:create()
    function TestWindow:testCreate()
        local function execution(existingWindow, shouldCallCreateFrame)
            local createTitleBarInvoked = false
            local createFrameInvoked = false

            local instance = __:new('Window', 'test-id')
            instance.createFrame = function() createFrameInvoked = true end
            instance.createTitleBar = function() createTitleBarInvoked = true end
            
            instance.window = existingWindow

            instance:create()

            lu.assertEquals(shouldCallCreateFrame, createFrameInvoked)
            lu.assertEquals(shouldCallCreateFrame, createTitleBarInvoked)
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

        lu.assertNotIsNil(instance.closeButton)
    end

    -- @covers Window:createFrame()
    function TestWindow:testCreateFrame()
        local instance = __:new('Window', 'test-id')

        local result = instance:createFrame()

        lu.assertEquals({
            bgFile = 'Interface/Tooltips/UI-Tooltip-Background',
            edgeFile = '',
            edgeSize = 4,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        }, result.backdrop)
        lu.assertEquals({ 0, 0, 0, .5 }, result.backdropColor)
        lu.assertEquals({ 0, 0, 0, 1 }, result.backdropBorderColor)
        lu.assertTrue(result.movable)
        lu.assertTrue(result.mouseEnabled)
        lu.assertTrue(result.resizable)
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
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        }, result.backdrop)
        lu.assertEquals({ 0, 0, 0, .8 }, result.backdropColor)
        lu.assertIsTrue(createCloseButtonInvoked)
        lu.assertIsTrue(createTitleTextInvoked)

        lu.assertNotIsNil(instance.titleBar)
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

        lu.assertNotIsNil(instance.titleText)
    end

    -- @covers Window:getWindow()
    function TestWindow:testGetWindow()
        local instance = __:new('Window', 'test-id')

        lu.assertIsNil(instance:getWindow())

        instance.window = {'test-window'}

        local result = instance:getWindow()

        lu.assertEquals(instance.window, result)
    end

    -- @covers Window:setFirstPosition()
    function TestWindow:testSetFirstPosition()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setFirstPosition({ point = 'TOP', relativePoint = 'TOP', xOfs = 10, yOfs = 10 })

        lu.assertEquals({ point = 'TOP', relativePoint = 'TOP', xOfs = 10, yOfs = 10 }, instance.firstPosition)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setFirstSize()
    function TestWindow:testSetFirstSize()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setFirstSize({ width = 200, height = 100 })

        lu.assertEquals({ width = 200, height = 100 }, instance.firstSize)
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
-- end of TestWindow