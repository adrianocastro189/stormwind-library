TestContainer = BaseTestClass:new()
    -- @covers Container:__construct()
    function TestContainer:testConstruct()
        local instance = __:new('Container')

        lu.assertNotNil(instance)
    end

    -- @covers Container:setSlot()
    function TestContainer:testSetters()
        local instance = __:new('Container')

        local result = instance
            :setSlot(1)

        lu.assertEquals(instance.slot, 1)

        -- asserts that the setters return the instance for chaining
        lu.assertEquals(result, instance)
    end
-- end of TestContainer