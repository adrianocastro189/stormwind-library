TestContainer = BaseTestClass:new()
    -- @covers Container:__construct()
    function TestContainer:testConstruct()
        local instance = __:new('Container')

        lu.assertNotNil(instance)
    end

    -- @covers Container:mapItems()
    function TestContainer:testMapItems()
        local instance = __:new('Container')

        local result = instance:mapItems()

        -- @TODO: Implement this test method in BG4 <2024.06.06>

        -- asserts that the method returns the instance for chaining
        lu.assertEquals(result, instance)
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