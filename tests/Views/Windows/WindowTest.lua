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
-- end of TestWindow