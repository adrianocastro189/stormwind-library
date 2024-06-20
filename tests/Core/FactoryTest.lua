TestFactory = BaseTestClass:new()
    -- @covers Factory:addClass()
    function TestFactory:testAddClassWithSpecificClients()
        local mockFlavorA = 'test-flavor-a'
        local mockFlavorB = 'test-flavor-b'

        lu.assertIsNil(__.classes[mockFlavorA])
        lu.assertIsNil(__.classes[mockFlavorB])

        -- adding with one specific client
        __:addClass('TestFactory', TestFactory, mockFlavorA)

        lu.assertEquals({['TestFactory'] = TestFactory}, __.classes[mockFlavorA])

        -- adding with multiple specific clients
        __:addClass('TestFactory', TestFactory, {mockFlavorA, mockFlavorB})

        lu.assertEquals({['TestFactory'] = TestFactory}, __.classes[mockFlavorA])
        lu.assertEquals({['TestFactory'] = TestFactory}, __.classes[mockFlavorB])
    end

    --[[
    @covers Factory.classes
    @covers Factory:addClass()
    @covers Factory:getClass()
    @covers Factory:new()
    ]]
    function TestFactory:testClassInstantiation()
        local MockClass = {}
        MockClass.__index = MockClass

        function MockClass.__construct(name)
            local self = setmetatable({}, MockClass)
            self.name = name
            return self
        end

        __:addClass('MockClass', MockClass)

        lu.assertNotIsNil(__.classes)
        lu.assertEquals(MockClass, __:getClass('MockClass'))

        local mockClassInstance = __:new('MockClass', 'test-name')

        lu.assertNotIsNil(mockClassInstance)
        lu.assertEquals('test-name', mockClassInstance.name)
    end

    -- @covers Factory.classTypes
    function TestFactory:testFactoryConstants()
        lu.assertEquals(1, __.classTypes.CLASS_TYPE_ABSTRACT)
        lu.assertEquals(2, __.classTypes.CLASS_TYPE_CONCRETE)

        -- makes sure the constants are immutable
        lu.assertError(function() __.classTypes.CLASS_TYPE_ABSTRACT = 3 end)
    end
-- end of TestFactory