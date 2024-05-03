TestItem = BaseTestClass:new()
    -- @covers Item:__construct()
    function TestItem:testConstruct()
        local instance = __:new('Item')

        lu.assertNotNil(instance)
    end

    -- @covers Item:setName()
    function TestItem:testSetName()
        local instance = __:new('Item')
        instance:setName('test-name')

        lu.assertEquals(instance.name, 'test-name')
    end
-- end of TestItem