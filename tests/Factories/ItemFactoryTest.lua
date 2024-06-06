TestItemFactory = BaseTestClass:new()
    -- @covers ItemFactory:__construct()
    function TestItemFactory:testLibraryInstanceIsSet()
        lu.assertNotNil(__.itemFactory)
    end
-- end of TestItemFactory