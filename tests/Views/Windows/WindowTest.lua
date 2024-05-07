TestWindow = BaseTestClass:new()
    -- @covers Window:config()
    function TestWindow:testConfig()
        local function execution(persistStateByPlayer, shouldCallConfig, shouldCallPlayerConfig)
            local configInvoked = false
            local playerConfigInvoked = false
            local args = nil

            local instance = __:new('Window', 'test-id')
            instance.persistStateByPlayer = persistStateByPlayer
            function instance.__:config(...) args = {...} configInvoked = true end
            function instance.__:playerConfig(...) args = {...} playerConfigInvoked = true end

            instance:config('arg1', 'arg2')

            lu.assertEquals(shouldCallConfig, configInvoked)
            lu.assertEquals(shouldCallPlayerConfig, playerConfigInvoked)
            lu.assertEquals({'arg1', 'arg2'}, args)
        end

        execution(nil, true, false)
        execution(false, true, false)
        execution(true, false, true)
    end

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
            local positionChildFramesInvoked = false
            local setWindowPositionOnCreationInvoked = false
            local setWindowSizeOnCreationInvoked = false
            local setWindowVisibilityOnCreationInvoked = false

            local instance = __:new('Window', 'test-id')
            instance.createContentFrame = function() createContentFrameInvoked = true end
            instance.createFooter = function() createFooterInvoked = true end
            instance.createFrame = function() createFrameInvoked = true end
            instance.createScrollbar = function() createScrollbarInvoked = true end
            instance.createTitleBar = function() createTitleBarInvoked = true end
            instance.positionContentChildFrames = function() positionChildFramesInvoked = true end
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
            lu.assertEquals(shouldCallCreateFrame, positionChildFramesInvoked)
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

    -- @covers Window:getProperty()
    function TestWindow:testGetProperty()
        local configArg = nil
        local getPropertyKeyArg = nil

        local instance = __:new('Window', 'test-id')

        function instance.__:config(key)
            configArg = key
            return 'test-value'
        end

        function instance:getPropertyKey(key)
            getPropertyKeyArg = key
            return 'test-key'
        end

        local result = instance:getProperty('test')
        
        lu.assertEquals('test', getPropertyKeyArg)
        lu.assertEquals('test-key', configArg)
        lu.assertEquals('test-value', result)
    end

    -- @covers Window:getPropertyKey()
    function TestWindow:testGetPropertyKey()
        local instance = __:new('Window', 'test-id')

        lu.assertEquals('windows.test-id.test-key', instance:getPropertyKey('test-key'))
    end

    -- @covers Window:getWindow()
    function TestWindow:testGetWindow()
        local instance = __:new('Window', 'test-id')

        lu.assertIsNil(instance:getWindow())

        instance.window = {'test-window'}

        local result = instance:getWindow()

        lu.assertEquals(instance.window, result)
    end

    -- @covers Window:hide()
    -- @covers Window:show()
    function TestWindow:testHideAndShowFacades()
        local hideInvoked = false
        local showInvoked = false

        local instance = __:new('Window', 'test-id')

        instance.window = {}
        instance.window.Hide = function() hideInvoked = true end
        instance.window.Show = function() showInvoked = true end

        instance:hide()
        instance:show()

        lu.assertIsTrue(hideInvoked)
        lu.assertIsTrue(showInvoked)
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

    -- @covers Window:positionContentChildFrames()
    function TestWindow:testPositionContentChildFrames()
        local contentFrameHeight, pointsA, pointsB = nil, {}, {}

        local childFrameA = {
            GetHeight = function() return 10 end,
            SetParent = function(self, parent) self.parent = parent end,
            SetPoint = function(self, ...) table.insert(pointsA, {...}) end
        }
        local childFrameB = {
            GetHeight = function() return 20 end,
            SetParent = function(self, parent) self.parent = parent end,
            SetPoint = function(self, ...) table.insert(pointsB, {...}) end
        }

        local instance = __:new('Window')
        instance.contentFrame = {
            SetHeight = function(self, height) contentFrameHeight = height end,
        }
        instance.contentChildren = {childFrameA, childFrameB}

        instance:positionContentChildFrames()

        lu.assertEquals(30, contentFrameHeight)
        lu.assertEquals({'TOPLEFT', instance.contentFrame, 'TOPLEFT', 0, 0}, pointsA[1])
        lu.assertEquals({'TOPRIGHT', instance.contentFrame, 'TOPRIGHT', 0, 0}, pointsA[2])
        lu.assertEquals({'TOPLEFT', childFrameA, 'BOTTOMLEFT', 0, 0}, pointsB[1])
        lu.assertEquals({'TOPRIGHT', childFrameA, 'BOTTOMRIGHT', 0, 0}, pointsB[2])
        lu.assertEquals(instance.contentFrame, childFrameA.parent)
    end

    -- @covers Window:setContent()
    function TestWindow:testSetContent()
        local function execution(contentFrame, shouldCallPositionChildFrames)
            local positionContentChildFramesInvoked = false

            local instance = __:new('Window')
            instance.contentFrame = contentFrame
            instance.positionContentChildFrames = function() positionContentChildFramesInvoked = true end
    
            local result = instance:setContent({'test-content'})
    
            lu.assertEquals(shouldCallPositionChildFrames, positionContentChildFramesInvoked)
            lu.assertEquals({'test-content'}, instance.contentChildren)
            lu.assertEquals(instance, result)
        end

        execution(nil, false)
        execution({'test-content-frame'}, true)
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

    -- @covers Window:setPersistStateByPlayer()
    function TestWindow:testSetPersistStateByPlayer()
        local instance = __:new('Window', 'test-id')

        lu.assertIsNil(instance.persistStateByPlayer)

        local result = instance:setPersistStateByPlayer(true)

        lu.assertTrue(instance.persistStateByPlayer)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setProperty()
    function TestWindow:testSetProperty()
        local configArg = nil
        local getPropertyKeyArg = nil

        local instance = __:new('Window', 'test-id')

        function instance.__:config(arg) configArg = arg end

        function instance:getPropertyKey(key)
            getPropertyKeyArg = key
            return 'test-key'
        end

        instance:setProperty('test', 'test-value')
        
        lu.assertEquals('test', getPropertyKeyArg)
        lu.assertEquals({['test-key'] = 'test-value'}, configArg)
    end

    -- @covers Window:setTitle()
    function TestWindow:testSetTitle()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setTitle('test-title')

        lu.assertEquals('test-title', instance.title)
        lu.assertEquals(instance, result)
    end

    -- @covers Window:setVisibility()
    function TestWindow:testSetVisibility()
        local function execution(visibility, isPersistingState, shouldCallShow, shouldCallHide, shouldCallSetProperty)
            local hideInvoked, setPropertyInvoked, showInvoked = false, false, false
            
            local instance = __:new('Window', 'test-id')

            instance.isPersistingState = function() return isPersistingState end

            instance.window = {}
            instance.window.Hide = function() hideInvoked = true end
            instance.window.Show = function() showInvoked = true end
            instance.setProperty = function() setPropertyInvoked = true end

            instance:setVisibility(visibility)

            lu.assertEquals(shouldCallShow, showInvoked)
            lu.assertEquals(shouldCallHide, hideInvoked)
            lu.assertEquals(shouldCallSetProperty, setPropertyInvoked)
        end

        -- visible and persisting state
        execution(true, true, true, false, true)

        -- visible and not persisting state
        execution(true, false, true, false, false)

        -- not visible and persisting state
        execution(false, true, false, true, true)

        -- not visible and not persisting state
        execution(false, false, false, true, false)
    end

    -- @covers Window:setWindowPositionOnCreation()
    function TestWindow:testSetWindowPositionOnCreation()
        local function execution(firstPosition, storedPosition, isPersistingState, expectedPosition)
            local pointArg, relativeToArg, relativePointArg, xOfsArg, yOfsArg = nil, nil, nil, nil, nil

            local instance = __:new('Window', 'test-id')
            instance.firstPosition = firstPosition
            instance.window = {}

            instance.window.SetPoint = function(self, point, relativeTo, relativePoint, xOfs, yOfs)
                pointArg = point
                relativeToArg = relativeTo
                relativePointArg = relativePoint
                xOfsArg = xOfs
                yOfsArg = yOfs
            end

            instance.isPersistingState = function() return isPersistingState end
            instance.getProperty = function(self, key) return storedPosition and storedPosition[key:match(".*%.(.*)")] or nil end

            instance:setWindowPositionOnCreation()

            lu.assertEquals(expectedPosition.point, pointArg)
            lu.assertEquals(expectedPosition.relativeTo, relativeToArg)
            lu.assertEquals(expectedPosition.relativePoint, relativePointArg)
            lu.assertEquals(expectedPosition.xOfs, xOfsArg)
            lu.assertEquals(expectedPosition.yOfs, yOfsArg)
        end
        
        -- not persisting state
        execution(
            {
                point = 'TOP',
                relativePoint = 'TOP',
                xOfs = 10,
                yOfs = 10,
            },
            nil,
            false,
            {
                point = 'TOP',
                relativePoint = 'TOP',
                xOfs = 10,
                yOfs = 10,
            }
        )

        -- persisting state with no stored values
        execution(
            {
                point = 'TOP',
                relativePoint = 'TOP',
                xOfs = 10,
                yOfs = 10,
            },
            nil,
            true,
            {
                point = 'TOP',
                relativePoint = 'TOP',
                xOfs = 10,
                yOfs = 10,
            }
        )

        -- persisting state with stored values
        execution(
            {
                point = 'TOP',
                relativePoint = 'TOP',
                xOfs = 10,
                yOfs = 10,
            },
            {
                point = 'BOTTOM',
                relativeTo = 'UIParent',
                relativePoint = 'BOTTOM',
                xOfs = 20,
                yOfs = 20,
            },
            true,
            {
                point = 'BOTTOM',
                relativeTo = 'UIParent',
                relativePoint = 'BOTTOM',
                xOfs = 20,
                yOfs = 20,
            }
        )
    end

    -- @covers Window:setWindowSizeOnCreation()
    function TestWindow:testSetWindowSizeOnCreation()
        local function execution(firstSizeW, firstSizeH, storedW, storedH, isPersistingState, expectedW, expectedH)
            local widthArg, heightArg = nil, nil

            local instance = __:new('Window', 'test-id')
            instance.firstSize = {width = firstSizeW, height = firstSizeH}
            instance.window = {}

            instance.window.SetSize = function(self, width, height)
                widthArg = width
                heightArg = height
            end

            instance.isPersistingState = function() return isPersistingState end
            instance.getProperty = function(self, key) return key == 'size.width' and storedW or storedH end

            instance:setWindowSizeOnCreation()

            lu.assertEquals(expectedW, widthArg)
            lu.assertEquals(expectedH, heightArg)
        end

        -- not persisting state
        execution(100, 110, 200, 210, false, 100, 110)

        -- persisting state with no stored values
        execution(100, 110, nil, nil, true, 100, 110)

        -- persisting state with stored values
        execution(100, 110, 200, 210, true, 200, 210)
    end

    -- @covers Window:setWindowVisibilityOnCreation()
    function TestWindow:testSetWindowVisibilityOnCreation()
        local function execution(firstVisibility, storedVisibility, isPersistingState, expectedVisibility)
            local setVisibilityArg = nil
            
            local instance = __:new('Window', 'test-id')
            instance.firstVisibility = firstVisibility
            instance.isPersistingState = function() return isPersistingState end
            instance.getProperty = function() return storedVisibility end
            instance.setVisibility = function(self, visibility) setVisibilityArg = visibility end
    
            instance:setWindowVisibilityOnCreation()

            lu.assertEquals(expectedVisibility, setVisibilityArg)
        end

        -- initially visible and not persisting state
        execution(true, nil, false, true)

        -- initially visible and persisting state with no stored value
        execution(true, nil, true, true)

        -- initially visible and persisting state with stored value
        execution(true, false, true, false)

        -- initially not visible and not persisting state
        execution(false, nil, false, false)

        -- initially not visible and persisting state with no stored value
        execution(false, nil, true, false)

        -- initially not visible and persisting state with stored value
        execution(false, true, true, true)
    end

    -- @covers Window:storeWindowPoint()
    -- @covers Window:storeWindowSize()
    function TestWindow:testStoreMethodsArentCalledIfNotPersistingState()
        local setPropertyInvoked = false

        local instance = __:new('Window', 'test-id')

        instance.window = {}
        instance.isPersistingState = function() return false end
        function instance:setProperty() setPropertyInvoked = true end

        instance:storeWindowPoint()
        instance:storeWindowSize()

        lu.assertIsFalse(setPropertyInvoked)
    end

    -- @covers Window:storeWindowPoint()
    function TestWindow:testStoreWindowPoint()
        local keyArgs, valueArgs = {}, {}

        local instance = __:new('Window', 'test-id')

        instance.window = {}
        instance.window.GetPoint = function() return 'CENTER', nil, 'CENTER', 0, 0 end
        instance.isPersistingState = function() return true end

        function instance:setProperty(key, value)
            table.insert(keyArgs, key)
            table.insert(valueArgs, value)
        end

        instance:storeWindowPoint()

        lu.assertEquals({
            'position.point',
            'position.relativeTo',
            'position.relativePoint',
            'position.xOfs',
            'position.yOfs',
        }, keyArgs)
        lu.assertEquals({'CENTER', 'CENTER', 0, 0}, valueArgs)
    end

    -- @covers Window:storeWindowSize()
    function TestWindow:testStoreWindowSize()
        local keyArgs, valueArgs = {}, {}

        local instance = __:new('Window', 'test-id')

        instance.window = {}
        instance.window.GetWidth = function() return 1 end
        instance.window.GetHeight = function() return 2 end
        instance.isPersistingState = function() return true end

        function instance:setProperty(key, value)
            table.insert(keyArgs, key)
            table.insert(valueArgs, value)
        end

        instance:storeWindowSize()

        lu.assertEquals({
            'size.height',
            'size.width',
        }, keyArgs)
        lu.assertEquals({2, 1}, valueArgs)
    end
-- end of TestWindow