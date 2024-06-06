TestItemFactory = BaseTestClass:new()
    -- @covers ItemFactory:__construct()
    function TestItemFactory:testLibraryInstanceIsSet()
        lu.assertNotNil(__.itemFactory)
    end

    -- @covers ItemFactory:createFromContainerItemInfo()
    function TestItemFactory:testCreateFromContainerItemInfo()
        local function execution(containerItemInfo, expectedResult)
            local item = __.itemFactory:createFromContainerItemInfo(containerItemInfo)

            if not expectedResult then
                lu.assertIsNil(item)
                return
            end

            lu.assertEquals(expectedResult.name, item.name)
            lu.assertEquals(expectedResult.id, item.id)
        end

        execution(nil, nil)
        execution({}, __:new('Item'))
        execution({
            ['itemName'] = 'test-item-name',
            ['itemID'] = 1
            }, __:new('Item')
                :setName('test-item-name')
                :setId(1))
    end
-- end of TestItemFactory