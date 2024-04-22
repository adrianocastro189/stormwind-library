--[[
Contains a list of classes that can be instantiated by the library.
]]
self.classes = {}

--[[
Registers a class so the library is able to instantiate it later.

This method's the same as updating self.classes.
]]
function self:addClass(classname, classStructure)
    self.classes[classname] = classStructure
end

--[[
Returns a class structure by its name.

This method's the same as accessing self.classes[classname].

@tparam string classname The name of the class to be returned
]]
function self:getClass(classname)
    return self.classes[classname]
end

--[[
This method emulates the new keyword in OOP languages by instantiating a
class by its name as long as the class has a __construct() method with or
without parameters.
]]
function self:new(classname, ...)
    return self:getClass(classname).__construct(...)
end