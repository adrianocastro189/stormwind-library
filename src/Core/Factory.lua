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
Registers an abstract class.

@tparam string classname The name of the abstract class to be registered
@tparam table classStructure The abstract class structure to be registered
@tparam nil|string|table clientFlavors The client flavors the class is supported by
--]]
function self:addAbstractClass(classname, classStructure, clientFlavors)
    self:addClass(classname, classStructure, clientFlavors, self.classTypes.CLASS_TYPE_ABSTRACT)
end

--[[--
Registers a class so the library is able to instantiate it later.

This method just updates the library classes table by registering a class
for the client flavors it's supported.

@tparam string classname The name of the class to be registered
@tparam table classStructure The class structure to be registered
@tparam nil|string|table clientFlavors The client flavors the class is supported by
@tparam integer|nil classType The class type, represented by the classTypes constants
]]
function self:addClass(classname, classStructure, clientFlavors, classType)
    local arr = self.arr

    -- defaults to concrete class if not specified
    classType = classType or self.classTypes.CLASS_TYPE_CONCRETE

    clientFlavors = arr:wrap(clientFlavors or {
        self.environment.constants.CLIENT_CLASSIC,
        self.environment.constants.CLIENT_CLASSIC_ERA,
        self.environment.constants.CLIENT_RETAIL,
        self.environment.constants.TEST_SUITE,
    })

    arr:each(clientFlavors, function(clientFlavor)
        arr:set(self.classes, clientFlavor .. '.' .. classname, {
            structure = classStructure,
            type = classType,
        })
    end)
end

--[[--
Provides class inheritance by extending a class structure with another by its
name.

Calling this method is the same of getting the parent class structure with
getClass() and setting the child class structure metatable. Consider this as
a helper method to improve code readability.

It's important to note that this method respects the client flavors strategy 
just like getClass(), which means it will only work properly if the parent
class is registered for the same client flavors as where this method is called.

@tparam table classStructure The class structure to be extended
@tparam string parentClassname The name of the parent class to be extended with
]]
function self:extend(classStructure, parentClassname)
    local parentStructure = self:getClass(parentClassname)
    setmetatable(classStructure, parentStructure)
end

--[[--
Returns a class structure by its name.

This method's the same as accessing self.classes[classname].

@tparam string classname The name of the class to be returned
@tparam string output The output format, either 'structure' (default) or 'type'

@treturn integer|table The class structure or type, depending on the output parameter
]]
function self:getClass(classname, output)
    local clientFlavor = self.environment:getClientFlavor()

    return self.classes[clientFlavor][classname][output or 'structure']
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
    local classType = self:getClass(classname, 'type')

    if classType == self.classTypes.CLASS_TYPE_ABSTRACT then
        error(classname .. ' is an abstract class and cannot be instantiated')
    end

    return self:getClass(classname).__construct(...)
end