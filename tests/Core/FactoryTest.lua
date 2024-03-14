TestFactory = {}
    --[[
    @covers Factory.classes
    @covers Factory:addClass()
    @covers Factory:new()
    ]]
    function TestFactory:testCanInstantiateClasses()
        local MockClass = {}
        MockClass.__index = MockClass

        function MockClass.__construct(name)
            local self = setmetatable({}, MockClass)
            self.name = name
            return self
        end

        local library = newLibrary()
        library:addClass('MockClass', MockClass)

        lu.assertNotIsNil(library.classes)

        local mockClassInstance = library:new('MockClass', 'test-name')

        lu.assertNotIsNil(mockClassInstance)
        lu.assertEquals(mockClassInstance.name, 'test-name')
    end
-- end of TestFactory