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

    -- @covers Inventory:mapBags()
    function TestInventory:testMapBags()
    -- @TODO: Implement this method in IV2 <2024.06.06>
    end

    -- @covers Inventory:refresh()
    function TestInventory:testRefresh()
    -- @TODO: Implement this method in IV2 <2024.06.06>
    end
-- end of TestInventory