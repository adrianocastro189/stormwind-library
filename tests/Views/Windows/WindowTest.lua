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

    -- @covers Window:setTitle()
    function TestWindow:testSetTitle()
        local instance = __:new('Window', 'test-id')
        
        local result = instance:setTitle('test-title')

        lu.assertEquals('test-title', instance.title)
        lu.assertEquals(instance, result)
    end
-- end of TestWindow