-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestPetJournal = BaseTestClass:new()
    -- @covers PetJournal:__construct()
    function TestPetJournal:testConstruct()
        local instance = __:new('PetJournal')

        lu.assertNotNil(instance)
    end

    -- @covers PetJournal:getSummonedPetSpeciesId()
    function TestPetJournal:testGetSummonedPetSpeciesId()
        local function execution(petGuid, expected)
            local instance = __:new('PetJournal')

            C_PetJournal.GetSummonedPetGUID = function () return petGuid end

            lu.assertEquals(expected, instance:getSummonedPetSpeciesId())
        end

        -- no pet summoned
        execution(nil, nil)

        -- pet summoned
        execution('test-pet-guid', 189)
    end

    -- @covers PetJournal:playerOwnsPet()
    function TestPetJournal:testPlayerOwnsPet()
        local instance = __:new('PetJournal')

        -- see wow-mocks.lua
        lu.assertTrue(instance:playerOwnsPet(1))
        lu.assertFalse(instance:playerOwnsPet(-1))
    end
-- end of TestPetJournal