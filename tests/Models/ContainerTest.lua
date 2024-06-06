TestContainer = BaseTestClass:new()
    -- @covers Container:__construct()
    function TestContainer:testConstruct()
        local instance = __:new('Container')

        lu.assertNotNil(instance)
    end

    -- @covers Container:getContainerItemInfo()
    function TestContainer:testGetContainerItemInfo()
        local instance = __:new('Container')

        local itemInformationMock = { 'test-item-information' }

        C_Container = {
            GetContainerItemInfo = function () return itemInformationMock end
        }

        lu.assertEquals(itemInformationMock, instance:getContainerItemInfo(1))
    end

    -- @covers Container:getItems()
    function TestContainer:testGetItems()
    -- @TODO: Implement this test method in BG5 <2024.06.06>
    end

    -- @covers Container:getNumSlots()
    function TestContainer:testGetNumSlots()
        local instance = __:new('Container')

        C_Container = {
            GetContainerNumSlots = function () return 1 end
        }

        local result = instance:getNumSlots()

        lu.assertEquals(result, 1)
    end

    -- @covers Container:hasItem()
    function TestContainer:testHasItem()
    -- @TODO: Implement this test method in BG5 <2024.06.06>
    end

    -- @covers Container:mapItems()
    function TestContainer:testMapItems()
        local instance = __:new('Container')

        local result = instance:mapItems()

        -- @TODO: Implement this test method in BG4 <2024.06.06>

        -- asserts that the method returns the instance for chaining
        lu.assertEquals(instance, result)
    end

    -- @covers Container:refresh()
    function TestContainer:testRefresh()
        local instance = __:new('Container')

        instance.mapItems = function () instance.mapItemsInvoked = true end

        instance:refresh()

        lu.assertTrue(instance.mapItemsInvoked)
    end

    -- @covers Container:setSlot()
    function TestContainer:testSetters()
        local instance = __:new('Container')

        local result = instance
            :setSlot(1)

        lu.assertEquals(instance.slot, 1)

        -- asserts that the setters return the instance for chaining
        lu.assertEquals(instance, result)
    end
-- end of TestContainer