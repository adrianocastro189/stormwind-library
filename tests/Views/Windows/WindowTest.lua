TestWindow = BaseTestClass:new()
    -- @covers Window:__construct()
    function TestWindow:testConstruct()
        local instance = __:new('Window', 'test-id')

        lu.assertNotNil(instance)
        lu.assertEquals(instance.id, 'test-id')
        lu.assertEquals(instance.firstSize.width, 128)
        lu.assertEquals(instance.firstSize.height, 128)
    end
-- end of TestWindow