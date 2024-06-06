TestInventory = BaseTestClass:new()
    -- @covers Inventory:__construct()
    function TestInventory:testConstruct()
        local instance = __:new('Inventory')

        lu.assertNotNil(instance)
    end
-- end of TestInventory