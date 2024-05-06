TestPlayer = BaseTestClass:new()
    -- @covers Player:__construct()
    function TestPlayer:testConstruct()
        local instance = __:new('Player')

        lu.assertNotNil(instance)
    end

    -- @covers Player:setGuid()
    -- @covers Player:setName()
    -- @covers Player:setRealm()
    function TestPlayer:testSetters()
        local realm = __:new('Realm'):setName('test-realm')

        local instance = __:new('Player')
        
        lu.assertIsNil(instance.guid)
        lu.assertIsNil(instance.name)
        lu.assertIsNil(instance.realm)

        local result = instance
            :setGuid('test-guid')
            :setName('test-name')
            :setRealm(realm)

        lu.assertEquals(result, instance)
        lu.assertEquals(instance.guid, 'test-guid')
        lu.assertEquals(instance.name, 'test-name')
        lu.assertEquals(instance.realm, realm)
    end
-- end of TestPlayer