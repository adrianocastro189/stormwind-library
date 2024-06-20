--[[--
Contains a list of class structures that Stormwind Library can handle to allow
instantiation, protection in case of abstractions, and inheritance.
]]
self.classes = {}

--[[--
Maps all the possible class types Stormwind Library can handle.
]]
self.classTypes = self.arr:freeze({
    CLASS_TYPE_ABSTRACT = 1,
    CLASS_TYPE_CONCRETE = 2,
})

--[[--
Registers a class so the library is able to instantiate it later.

This method just updates the library classes table by registering a class
for the client flavors it's supported.

@tparam string classname The name of the class to be registered
@tparam table classStructure The class structure to be registered
@tparam nil|string|table clientFlavors The client flavors the class is supported by
]]
function self:addClass(classname, classStructure, clientFlavors)
    local arr = self.arr

    clientFlavors = arr:wrap(clientFlavors or {
        self.environment.constants.CLIENT_CLASSIC,
        self.environment.constants.CLIENT_CLASSIC_ERA,
        self.environment.constants.CLIENT_RETAIL,
        self.environment.constants.TEST_SUITE,
    })

    arr:each(clientFlavors, function(clientFlavor)
        arr:set(self.classes, clientFlavor .. '.' .. classname, classStructure)
    end)
end

--[[--
Returns a class structure by its name.

This method's the same as accessing self.classes[classname].

@tparam string classname The name of the class to be returned

@treturn table The class structure
]]
function self:getClass(classname)
    local clientFlavor = self.environment:getClientFlavor()

    return self.classes[clientFlavor][classname]
end

--[[--
This method emulates the new keyword in OOP languages by instantiating a
class by its name as long as the class has a __construct() method with or
without parameters.

@tparam string classname The name of the class to be instantiated
@param ... The parameters to be passed to the class constructor

@treturn table The class instance
]]
function self:new(classname, ...)
    return self:getClass(classname).__construct(...)
end