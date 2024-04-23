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
            local instance = __:new('Window', 'test-id')
            instance.window = existingWindow

            local createFrameCalled = false

            instance.createFrame = function() createFrameCalled = true end

            instance:create()

            lu.assertEquals(shouldCallCreateFrame, createFrameCalled)
        end

        execution(nil, true)
        execution({}, false)
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