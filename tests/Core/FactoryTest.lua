TestFactory = BaseTestClass:new()
    --@covers Factory:addClass()
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
-- end of TestFactory