-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestContainer = BaseTestClass:new()
    -- @covers Container:__construct()
    function TestContainer:testConstruct()
        local instance = __:new('Container')

        lu.assertNotNil(instance)
        lu.assertTrue(instance.outdated)
    end

    -- @covers Container:flagOutdated()
    function TestContainer:testFlagOutdated()
        local instance = __:new('Container')

        instance.outdated = false

        local result = instance:flagOutdated()

        lu.assertTrue(instance.outdated)

        -- asserts that the method returns the instance for chaining
        lu.assertEquals(instance, result)
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
        local execution = function (items, outdated, shouldCallMapItems, mappedItems)
            local instance = __:new('Container')

            instance.mapItemsInvoked = false
            instance.outdated = outdated

            instance.mapItems = function ()
                instance.items = mappedItems
                instance.mapItemsInvoked = true
            end

            instance.items = items

            lu.assertEquals(mappedItems, instance:getItems())
            lu.assertEquals(shouldCallMapItems, instance.mapItemsInvoked)
        end

        local items = { 'test-item-1', 'test-item-2' }

        -- items are null, not outdated
        execution(nil, false, true, items)

        -- items are empty, not outdated
        execution({}, false, false, {})

        -- items are set, but not outdated
        execution(items, false, false, items)

        -- items are set, but outdated
        execution(items, true, true, items)
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
        local instance = __:new('Container')

        local itemA = __:new('Item'):setId(1)
        local itemB = __:new('Item'):setId(2)
        local itemC = __:new('Item'):setId(3)

        instance.items = { itemA, itemB }
        instance.outdated = false

        lu.assertTrue(instance:hasItem(1))
        lu.assertTrue(instance:hasItem(itemA))

        lu.assertFalse(instance:hasItem(3))
        lu.assertFalse(instance:hasItem(itemC))
    end

    -- @covers Container:mapItems()
    function TestContainer:testMapItems()
        local instance = __:new('Container')

        instance.getNumSlots = function () return 3 end
        instance.getContainerItemInfo = function (self, slot)
            if slot == 2 then
                -- emulates a slot without an item
                return nil
            end

            return {
                itemID = 1,
                itemName = 'test-item-name',
            }
        end
        instance.outdated = true

        local result = instance:mapItems()

        local item = __:new('Item')
            :setId(1)
            :setName('test-item-name')

        lu.assertEquals({item, item}, result.items)
        lu.assertFalse(result.outdated)

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