TestRealm = BaseTestClass:new()
    -- @covers Realm:__construct()
    function TestRealm:testConstruct()
        local instance = __:new('Realm')

        lu.assertNotNil(instance)
    end

    -- @covers Realm.getCurrentRealm()
    function TestRealm:testGetCurrentRealm()
        local result = __:getClass('Realm').getCurrentRealm()

        lu.assertEquals(result.name, 'test-realm')
    end

    -- @covers Realm:setName()
    function TestRealm:testSetName()
        local instance = __:new('Realm')
        
        local result = instance:setName('test-name')

        lu.assertEquals(instance.name, 'test-name')
        lu.assertEquals(result, instance)
    end
-- end of TestRealm