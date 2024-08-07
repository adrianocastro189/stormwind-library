-- @TODO: Move this test class to the new TestCase structure <2024.07.30>

TestPlayer = BaseTestClass:new()
    -- @covers Player:__construct()
    function TestPlayer:testConstruct()
        local instance = __:new('Player')

        lu.assertNotNil(instance)
    end

    -- @covers Player.getCurrentPlayer()
    function TestPlayer:testGetCurrentPlayer()
        UnitLevel = function () return 10 end

        local result = __:getClass('Player').getCurrentPlayer()

        lu.assertEquals(10, result.level)
        lu.assertEquals('test-player-guid', result.guid)
        lu.assertIsTrue(result.inCombat)
        lu.assertEquals('test-player-name', result.name)
        lu.assertEquals('test-realm', result.realm.name)
    end

    -- @covers StormwindLibrary.currentPlayer
    function TestPlayer:testLibraryInstanceIsSet()
        local result = __.currentPlayer

        lu.assertEquals('test-player-name', result.name)
        lu.assertEquals('test-player-guid', result.guid)
        lu.assertEquals('test-realm', result.realm.name)
    end

    -- @covers Player:setGuid()
    -- @covers Player:setLevel()
    -- @covers Player:setName()
    -- @covers Player:setRealm()
    function TestPlayer:testSetters()
        local realm = __:new('Realm'):setName('test-realm')

        local instance = __:new('Player')
        
        lu.assertIsNil(instance.guid)
        lu.assertIsNil(instance.inCombat)
        lu.assertIsNil(instance.level)
        lu.assertIsNil(instance.name)
        lu.assertIsNil(instance.realm)

        local result = instance
            :setGuid('test-guid')
            :setInCombat(true)
            :setLevel(1)
            :setName('test-name')
            :setRealm(realm)

        lu.assertEquals(instance, result)
        lu.assertEquals('test-guid', instance.guid)
        lu.assertEquals(true, result.inCombat)
        lu.assertEquals(1, instance.level)
        lu.assertEquals('test-name', instance.name)
        lu.assertEquals(realm, instance.realm)
    end
-- end of TestPlayer