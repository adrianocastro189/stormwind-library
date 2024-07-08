TestInventory = BaseTestClass:new()
    -- @covers Inventory:__construct()
    function TestInventory:testConstruct()
        local instance = __:new('Inventory')

        lu.assertNotNil(instance)
        lu.assertTrue(instance.outdated)
    end

    -- @covers Inventory:flagOutdated()
    function TestInventory:testFlagOutdated()
        local instance = __:new('Inventory')

        local containerMock = __:new('Container')
        containerMock.flagOutdated = function ()
            containerMock.flagOutdatedInvoked = true
            return containerMock
        end

        instance.containers = { containerMock }

        instance.outdated = false

        local result = instance:flagOutdated()

        lu.assertTrue(instance.outdated)
        lu.assertTrue(containerMock.flagOutdatedInvoked)
        lu.assertEquals(instance, result)
    end

    -- @covers Inventory:getItems()
    function TestInventory:testGetItems()
        local instance = __:new('Inventory')

        local containerA, containerB = __:new('Container'), __:new('Container')

        containerA.getItems = function () return { 'itemA1', 'itemA2' } end
        containerB.getItems = function () return { 'itemB1', 'itemB2' } end

        instance.containers = { containerA, containerB }

        local result = instance:getItems()

        lu.assertEquals({ 'itemA1', 'itemA2', 'itemB1', 'itemB2' }, result)
    end

    -- @covers Inventory:hasItem()
    function TestInventory:testHasItem()
        local function execution(containers, expectedOutput)
            local instance = __:new('Inventory')

            instance.containers = containers

            lu.assertEquals(expectedOutput, instance:hasItem())
        end

        local containerHasItem = { hasItem = function () return true end }
        local containerHasNotItem = { hasItem = function () return false end }

        -- with no containers
        execution({}, false)

        -- with one container that has the item
        execution({ containerHasItem }, true)

        -- with one container that has not the item
        execution({ containerHasNotItem }, false)

        -- with two containers
        execution({ containerHasNotItem, containerHasItem }, true)
    end

    -- @covers Inventory:mapContainers()
    function TestInventory:testMapContainers()
        local instance = __:new('Inventory')

        __.arr:maybeInitialize(_G, 'Enum.BagIndex', { TestBag = 1 })

        local bagMock = __:new('Container')
        bagMock.mapItems = function ()
            bagMock.mapItemsInvoked = true
            return bagMock
        end

        __.new = function () return bagMock end

        local result = instance:mapContainers()

        lu.assertTrue(bagMock.mapItemsInvoked)
        lu.assertEquals({ bagMock }, instance.containers)
        lu.assertEquals(instance, result)

        _G.Enum = nil
    end

    -- @covers Inventory:mapContainers()
    function TestInventory:testMapContainersWithEnumNotSet()
        local instance = __:new('Inventory')

        instance:mapContainers()

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