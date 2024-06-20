TestFactory = BaseTestClass:new()
    -- @covers Factory:addClass()
    function TestFactory:testAddClassWithSpecificClients()
        local mockFlavorA = 'test-flavor-a'
        local mockFlavorB = 'test-flavor-b'

        lu.assertIsNil(__.classes[mockFlavorA])
        lu.assertIsNil(__.classes[mockFlavorB])

        -- adding with one specific client
        __:addClass('TestFactory', TestFactory, mockFlavorA)

        lu.assertEquals({
            ['TestFactory'] = {
                structure = TestFactory,
                type = __.classTypes.CLASS_TYPE_CONCRETE,
            }
        }, __.classes[mockFlavorA])

        -- adding with multiple specific clients
        __:addClass('TestFactory', TestFactory, {mockFlavorA, mockFlavorB})

        lu.assertEquals({
            ['TestFactory'] = {
                structure = TestFactory,
                type = __.classTypes.CLASS_TYPE_CONCRETE,
            },
        }, __.classes[mockFlavorA])

        lu.assertEquals({
            ['TestFactory'] = {
                structure = TestFactory,
                type = __.classTypes.CLASS_TYPE_CONCRETE,
            },
        }, __.classes[mockFlavorB])
    end

    -- @covers Factory:addClass()
    function TestFactory:testAddClassWithSpecificType()
        __:addClass('TestFactory', TestFactory, nil, 3)

        lu.assertEquals({
            structure = TestFactory,
            type = 3,
        }, __.classes[__.environment.constants.CLIENT_CLASSIC]['TestFactory'])
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

    -- @covers Factory:addAbstractClass()
    -- @covers Factory:new()
    function TestFactory:testClassInstantiationWithAbstractClass()
        __:addAbstractClass('MockAbstractClass', TestFactory, nil)

        lu.assertErrorMsgContains(
            'MockAbstractClass is an abstract class and cannot be instantiated',
            function () __:new('MockAbstractClass') end
        )
    end

    -- @covers Factory:extend()
    function TestFactory:testExtend()
        local parentClass = {}
        parentClass.__index = parentClass
        function parentClass.__construct() return setmetatable({}, parentClass) end
        parentClass.property = 'property'
        function parentClass:get() return self.property .. ' from parent' end
        __:addClass('ParentClass', parentClass)

        local childClass = {}
        childClass.__index = childClass
        function childClass.__construct() return setmetatable({}, childClass) end
        __:extend(childClass, 'ParentClass')
        function childClass:get() return self.property .. ' from child' end
        __:addClass('ChildClass', childClass)

        lu.assertEquals('property from child', __:new('ChildClass'):get())
    end

    -- @covers Factory.classTypes
    function TestFactory:testFactoryConstants()
        lu.assertEquals(1, __.classTypes.CLASS_TYPE_ABSTRACT)
        lu.assertEquals(2, __.classTypes.CLASS_TYPE_CONCRETE)

        -- makes sure the constants are immutable
        lu.assertError(function() __.classTypes.CLASS_TYPE_ABSTRACT = 3 end)
    end
-- end of TestFactory