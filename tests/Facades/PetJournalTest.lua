TestPetJournal = BaseTestClass:new()
    -- @covers PetJournal:__construct()
    function TestPetJournal:testConstruct()
        local instance = __:new('PetJournal')

        lu.assertNotNil(instance)
    end
-- end of TestPetJournal