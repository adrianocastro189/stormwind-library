-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestItem = BaseTestClass:new()
    -- @covers Item:__construct()
    function TestItem:testConstruct()
        local instance = __:new('Item')

        lu.assertNotNil(instance)
    end

    -- @covers Item:setId()
    -- @covers Item:setName()
    function TestItem:testSetters()
        local instance = __:new('Item')

        local result = instance
            :setId(1)
            :setName('test-name')

        lu.assertEquals(instance.id, 1)
        lu.assertEquals(instance.name, 'test-name')

        -- asserts that the setters return the instance for chaining
        lu.assertEquals(instance, result)
    end
-- end of TestItem