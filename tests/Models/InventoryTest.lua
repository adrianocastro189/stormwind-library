TestInventory = BaseTestClass:new()
    -- @covers Inventory:__construct()
    function TestInventory:testConstruct()
        local instance = __:new('Inventory')

        lu.assertNotNil(instance)
    end

    -- @covers Inventory:getItems()
    function TestInventory:testGetItems()
    -- @TODO: Implement this method in IV3 <2024.06.06>
    end

    -- @covers Inventory:hasItem()
    function TestInventory:testHasItem()
    -- @TODO: Implement this method in IV3 <2024.06.06>
    end

    -- @covers StormwindLibrary.playerInventory
    function TestInventory:testLibraryInstanceIsSet()
        lu.assertNotNil(__.playerInventory)
    end

    -- @covers Inventory:mapBags()
    function TestInventory:testMapBags()
        local instance = __:new('Inventory')

        __.arr:maybeInitialize(_G, 'Enum.BagIndex', { TestBag = 1 })

        local bagMock = __:new('Container')
        bagMock.mapItems = function ()
            bagMock.mapItemsInvoked = true
            return bagMock
        end

        __.new = function () return bagMock end

        local result = instance:mapBags()

        lu.assertTrue(bagMock.mapItemsInvoked)
        lu.assertEquals({ bagMock }, instance.containers)
        lu.assertEquals(instance, result)

        _G.Enum = nil
    end

    -- @covers Inventory:mapBags()
    function TestInventory:testMapBagsWithEnumNotSet()
        local instance = __:new('Inventory')

        instance:mapBags()

        lu.assertIsNil(instance.bags)
    end

    -- @covers Inventory:refresh()
    function TestInventory:testRefresh()
        local instance = __:new('Inventory')

        local containerMock = __:new('Container')
        containerMock.refresh = function ()
            containerMock.refreshInvoked = true
            return containerMock
        end

        instance.containers = { containerMock }

        local result = instance:refresh()

        lu.assertTrue(containerMock.refreshInvoked)
        lu.assertEquals(instance, result)
    end
-- end of TestInventory